part of 'batch_operate.dart';

class _PutConversationStrategy implements _StrategyBase {
  @override
  final Operation operation;
  @override
  final Scope scope;

  const _PutConversationStrategy({
    required this.operation,
    required this.scope,
  });

  @override
  Future<void> apply() async {
    final payload = jsonDecode(operation.payload)['payload'];
    late Conversation conversation;
    final portable = PortableConversation.fromBuffer(
      base64Decode(payload['conversation']),
    );

    final agent = portable.findAgent(scope);
    // 查询 Conversation 是否存在
    final select = scope.db.conversations.select();
    select.where((tbl) => tbl.type.equalsValue(portable.type));
    select.where((tbl) => tbl.signPubkey.equals(agent.signPubKey));
    final exist = await select.getSingleOrNull();

    if (exist == null) {
      // 创建会话
      conversation = await scope.db.conversations.insertReturning(
        ConversationsCompanion.insert(
          type: portable.type,
          ecdhPubkey: agent.ecdhPubKey,
          signPubkey: agent.signPubKey,
          info: portable,
        ),
      );
    } else {
      // 应用会话
      final update = scope.db.conversations.update();
      update.where((tbl) => tbl.id.equals(exist.id));
      final conversations = await update.writeReturning(ConversationsCompanion(
        info: Value(portable),
      ));
      conversation = conversations.first;
    }

    // members
    final updateContacts = <(AccountSnapshot, AccountSnapshot)>[];
    final createContacts = <AccountSnapshot>[];
    // relation
    final createRelation = <AccountSnapshot>[];
    final deleteRelation = <AccountSnapshot>[];
    for (final member in portable.members) {
      final select = scope.db.contacts.select();
      select.where((tbl) => tbl.signPubkey.equals(member.index.signPubKey));
      late Contact contact;
      // 更新联系人信息
      final record = await select.getSingleOrNull();
      if (record == null) {
        final insert = await scope.db.contacts.insertReturning(
          ContactsCompanion.insert(
            signPubkey: member.index.signPubKey,
            snapshot: member,
          ),
        );
        contact = insert;
        createContacts.add(member);
      } else {
        final update = scope.db.contacts.update();
        update.where((tbl) => tbl.id.equals(record.id));
        final contacts = await update.writeReturning(ContactsCompanion(
          snapshot: Value(member),
        ));
        contact = contacts.first;
        updateContacts.add((record.snapshot, member));
      }

      final selectRelation = scope.db.conversationContacts.select();
      selectRelation.where((tbl) => tbl.contactId.equals(contact.id));
      selectRelation.where((tbl) => tbl.conversationId.equals(conversation.id));
      final relation = await selectRelation.getSingleOrNull();
      if (relation == null) {
        await scope.db.conversationContacts.insertOne(
          ConversationContactsCompanion.insert(
            conversationId: conversation.id,
            contactId: contact.id,
          ),
        );
        createRelation.add(member);
      }
    }
    final selectDelete = scope.db.conversationContacts.select().join([
      innerJoin(
        scope.db.contacts,
        scope.db.contacts.id.equalsExp(
          scope.db.conversationContacts.contactId,
        ),
      )
    ]);
    selectDelete.where(
      scope.db.contacts.signPubkey.isNotIn(
        portable.members.map((e) => e.index.signPubKey),
      ),
    );
    final records = await selectDelete.get();
    for (final record in records) {
      final relation = record.readTable(scope.db.conversationContacts);
      final contact = record.readTable(scope.db.contacts);
      deleteRelation.add(contact.snapshot);
      await scope.db.conversationContacts.deleteOne(relation);
    }

    final applyMap = {
      'conversation': {
        'from': exist == null
            ? 'null'
            : base64Encode(
                exist.info.writeToBuffer(),
              ),
        'to': base64Encode(portable.writeToBuffer()),
      },
      'contacts': {
        'create':
            createContacts.map((e) => base64Encode(e.writeToBuffer())).toList(),
        'update': updateContacts
            .map(
              (e) => {
                'from': base64Encode(e.$1.writeToBuffer()),
                'to': base64Encode(e.$2.writeToBuffer()),
              },
            )
            .toList(),
      },
      'relations': {
        'create':
            createRelation.map((e) => base64Encode(e.writeToBuffer())).toList(),
        'delete':
            deleteRelation.map((e) => base64Encode(e.writeToBuffer())).toList(),
      },
    };
    final updateOperation = scope.db.operations.update();
    updateOperation.where((tbl) => tbl.id.equals(operation.id));
    await updateOperation.write(OperationsCompanion(
      apply: Value(jsonEncode(applyMap)),
    ));
  }

  @override
  Future<void> revert() async {
    final Map applyMap = jsonDecode(operation.apply);
    // revert conversation
    final portableConversation = PortableConversation.fromBuffer(
      base64Decode(applyMap['conversation']['to']),
    );

    final agent = portableConversation.findAgent(scope);
    // 查询 Conversation 是否存在
    final select = scope.db.conversations.select();
    select.where((tbl) => tbl.type.equalsValue(portableConversation.type));
    select.where((tbl) => tbl.signPubkey.equals(agent.signPubKey));
    final conversation = await select.getSingle();
    final conversationFrom = applyMap['conversation']['from'];
    if (conversationFrom == 'null') {
      await scope.db.conversations.deleteOne(conversation);
    } else {
      final update = scope.db.conversations.update();
      update.where((tbl) => tbl.id.equals(conversation.id));
      await update.write(
        ConversationsCompanion(
          info: Value(
            PortableConversation.fromBuffer(base64Decode(conversationFrom)),
          ),
        ),
      );
    }

    // revert create relation
    final List createRelationList = applyMap['relations']['create'];
    final createRelation = createRelationList
        .map((e) => e.toString())
        .map((e) => base64Decode(e))
        .map((e) => AccountSnapshot.fromBuffer(e));
    final selectCreateRelation = scope.db.conversationContacts.select().join([
      innerJoin(
        scope.db.contacts,
        scope.db.contacts.signPubkey.isIn(
          createRelation.map((e) => e.index.signPubKey),
        ),
      ),
    ]);
    selectCreateRelation.where(
      scope.db.conversationContacts.conversationId.equals(conversation.id),
    );
    final createRelationRecords = await selectCreateRelation.get();
    await scope.db.conversationContacts.deleteWhere(
      (tbl) => tbl.id.isIn(
        createRelationRecords
            .map((e) => e.readTable(scope.db.conversationContacts))
            .map((e) => e.id),
      ),
    );
    // revert delete relation
    final List deleteRelationList = applyMap['relations']['delete'];
    final deleteRelation = deleteRelationList
        .map((e) => e.toString())
        .map((e) => base64Decode(e))
        .map((e) => AccountSnapshot.fromBuffer(e));
    final selectDeleteContacts = scope.db.contacts.select();
    selectDeleteContacts.where(
      (tbl) => tbl.signPubkey.isIn(
        deleteRelation.map((e) => e.index.signPubKey),
      ),
    );
    final deleteContacts = await selectDeleteContacts.get();
    for (final contact in deleteContacts) {
      await scope.db.conversationContacts.insertOne(
        ConversationContactsCompanion.insert(
          conversationId: conversation.id,
          contactId: contact.id,
        ),
      );
    }
    // revert create contacts
    final List createContactsList = applyMap['contacts']['create'];
    final createContacts = createContactsList
        .map((e) => base64Decode(e))
        .map((e) => AccountSnapshot.fromBuffer(e));
    await scope.db.contacts.deleteWhere(
      (tbl) => tbl.signPubkey.isIn(
        createContacts.map((e) => e.index.signPubKey),
      ),
    );
    // revert update contacts
    final List updateContactsList = applyMap['contacts']['update'];
    for (final updateContact in updateContactsList) {
      final from = AccountSnapshot.fromBuffer(
        base64Decode(updateContact['from']),
      );
      final to = AccountSnapshot.fromBuffer(
        base64Decode(updateContact['to']),
      );
      final update = scope.db.contacts.update();
      update.where((tbl) => tbl.signPubkey.equals(to.index.signPubKey));
      await update.write(ContactsCompanion(
        snapshot: Value(from),
      ));
    }

    // revert operation apply
    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    await update.write(const OperationsCompanion(apply: Value('')));
  }
}
