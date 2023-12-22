import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:ENC/extensions/portable_conversation/portable_conversation.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/operator/context.dart';
import 'package:ENC/scope/operator/operate_atom/operate_atom.dart';
import 'package:ENC/scope/operator/operate_atom/operate_atom_type.dart';
import 'package:ENC/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:ENC/utils/group_helper.dart';

class PutConversationAtomProceeder
    implements AtomProceeder<PortableConversation> {
  @override
  Future<OperateAtom?> apply(
    OperateContext context,
    PortableConversation portable,
  ) async {
    final scope = context.scope;
    final agent = portable.findAgent(scope);
    // 查询 Conversation 是否存在
    final select = scope.db.conversations.select();
    select.where((tbl) => tbl.type.equalsValue(portable.type));
    select.where((tbl) => tbl.signPubkey.equals(agent.signPubKey));
    final exist = await select.getSingleOrNull();

    late Conversation conversation;
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
      if (portable.type == ConversationType.CONVERSATION_GROUP &&
          !context.isReplay) {
        context.afterTranscation.add(
          () => GroupHelper.pullMessage(scope, conversation),
        );
      }
    } else {
      // 私聊 Conversation 不会发生变化，所以略过变更
      if (portable.type == ConversationType.CONVERSATION_PRIVATE) {
        return null;
      }

      if (exist.info.version >= portable.version) {
        return null;
      }

      // 检测是否需要从群聊处全量拉取信息
      var shouldPullMessage = true;
      for (final member in exist.info.members) {
        if (member.index.signPubKey == scope.secret.signPubKey) {
          shouldPullMessage = false;
          break;
        }
      }
      if (shouldPullMessage) {
        context.afterTranscation.add(
          () => GroupHelper.pullMessage(scope, conversation),
        );
      }

      final update = scope.db.conversations.update();
      update.where((tbl) => tbl.id.equals(exist.id));
      final conversations = await update.writeReturning(ConversationsCompanion(
        info: Value(portable),
      ));
      conversation = conversations.first;
    }

    await applyMembers(scope, conversation, portable);

    return OperateAtom(
      type: OperateAtomType.putConversation,
      from: exist == null ? null : base64Encode(exist.info.writeToBuffer()),
      to: base64Encode(portable.writeToBuffer()),
    );
  }

  @override
  Future<void> revert(OperateContext context, OperateAtom atom) async {
    final scope = context.scope;
    final portableConversation = PortableConversation.fromBuffer(
      base64Decode(atom.to),
    );

    final agent = portableConversation.findAgent(scope);
    // 查询 Conversation 是否存在
    final select = scope.db.conversations.select();
    select.where((tbl) => tbl.type.equalsValue(portableConversation.type));
    select.where((tbl) => tbl.signPubkey.equals(agent.signPubKey));
    final conversation = await select.getSingle();
    final conversationFrom = atom.from;
    if (conversationFrom == null) {
      await scope.db.conversations.deleteOne(conversation);
      await scope.db.conversationContacts.deleteWhere(
        (tbl) => tbl.conversationId.equals(conversation.id),
      );
    } else {
      final from = PortableConversation.fromBuffer(
        base64Decode(conversationFrom),
      );
      final update = scope.db.conversations.update();
      update.where((tbl) => tbl.id.equals(conversation.id));
      await update.write(
        ConversationsCompanion(
          info: Value(from),
        ),
      );
      await applyMembers(scope, conversation, from);
    }
  }

  // diff and apply members
  // this is a common logic
  Future<void> applyMembers(
    Scope scope,
    Conversation conversation,
    PortableConversation portable,
  ) async {
    final selectCurrentMembers = scope.db.conversationContacts.select().join([
      innerJoin(
        scope.db.contacts,
        scope.db.contacts.id.equalsExp(
          scope.db.conversationContacts.contactId,
        ),
      ),
    ]);
    selectCurrentMembers.where(
      scope.db.conversationContacts.conversationId.equals(conversation.id),
    );
    final currentMemberRecords = await selectCurrentMembers.get();
    final currentMemberSet = currentMemberRecords
        .map((e) => e.read(scope.db.contacts.signPubkey))
        .toSet();
    final appendList = <int>[];
    for (final member in portable.members) {
      if (!currentMemberSet.contains(member.index.signPubKey)) {
        final select = scope.db.contacts.select();
        select.where((tbl) => tbl.signPubkey.equals(member.index.signPubKey));
        final target = await select.getSingle();
        appendList.add(target.id);
      }
    }
    for (final append in appendList) {
      await scope.db.conversationContacts.insertOne(
        ConversationContactsCompanion.insert(
          conversationId: conversation.id,
          contactId: append,
        ),
      );
    }

    final selectDeleteMembers = scope.db.conversationContacts.select().join([
      innerJoin(
        scope.db.contacts,
        scope.db.contacts.id.equalsExp(
          scope.db.conversationContacts.contactId,
        ),
      )
    ]);
    selectDeleteMembers.where(
      scope.db.conversationContacts.conversationId.equals(
        conversation.id,
      ),
    );
    selectDeleteMembers.where(
      scope.db.contacts.signPubkey.isNotIn(
        portable.members.map((e) => e.index.signPubKey),
      ),
    );
    final deleteMembers = await selectDeleteMembers.get();
    final deleteIds = deleteMembers.map(
      (e) => e.read(scope.db.conversationContacts.id)!,
    );
    await scope.db.conversationContacts.deleteWhere(
      (tbl) => tbl.id.isIn(deleteIds),
    );
  }
}
