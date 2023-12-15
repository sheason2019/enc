import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sheason_chat/cyprto/crypto_utils.dart';
import 'package:sheason_chat/dio.dart';
import 'package:sheason_chat/extensions/portable_conversation/portable_conversation.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:uuid/uuid.dart';

class ChatController extends ChangeNotifier {
  final Scope scope;
  final Conversation conversation;

  final uploads = <Future>[];

  ChatController({
    required this.scope,
    required this.conversation,
  }) {
    _watchMessages();
    _watchUncheck();
  }

  bool get useTextInput => _useTextInput;
  set useTextInput(bool value) {
    _useTextInput = value;
    notifyListeners();
  }

  var _useTextInput = true;

  var onUpdates = <void Function()>[];

  var ids = <int>[];
  StreamSubscription? idsSub;
  StreamSubscription? uncheckSub;
  void _watchMessages() {
    final db = scope.db;
    final select = db.messages.selectOnly();
    select.addColumns([db.messages.id]);
    select.where(db.messages.conversationId.equals(conversation.id));
    select.orderBy([
      OrderingTerm.asc(db.messages.createdAt),
    ]);
    final stream = select
        .watch()
        .map((event) => event.map((e) => e.read(db.messages.id)!).toList());
    idsSub = stream.listen((messages) async {
      final initId = await _fetchInitIndex();
      var initIndex = messages.indexOf(initId);
      if (initIndex == -1) {
        initIndex = messages.length;
      }
      messages.insert(initIndex, -1);
      messages.insert(messages.length, -2);
      ids = messages;
      inited = true;
      notifyListeners();
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        final onUpdates = this.onUpdates;
        this.onUpdates = [];
        for (final onUpdate in onUpdates) {
          onUpdate();
        }
      });
    });
  }

  var uncheck = 0;
  void _watchUncheck() {
    final count = scope.db.messageStates.id.count();
    final select = scope.db.messageStates.selectOnly().join([
      innerJoin(
        scope.db.contacts,
        scope.db.contacts.id.equalsExp(scope.db.messageStates.contactId),
      ),
      innerJoin(
        scope.db.messages,
        scope.db.messages.id.equalsExp(scope.db.messageStates.messageId),
      ),
    ]);
    select.addColumns([count]);
    select.where(scope.db.contacts.signPubkey.equals(scope.secret.signPubKey));
    select.where(scope.db.messageStates.checkedAt.isNull());
    select.where(scope.db.messages.conversationId.equals(conversation.id));
    final stream = select.watchSingle().map((event) => event.read(count)!);
    uncheckSub = stream.listen((event) {
      uncheck = event;
      notifyListeners();
    });
  }

  var inited = false;

  Future<int> _fetchInitIndex() async {
    final db = scope.db;

    final select = db.messageStates.selectOnly().join([
      innerJoin(
        db.messages,
        db.messages.id.equalsExp(db.messageStates.messageId),
      ),
      innerJoin(
        db.contacts,
        db.contacts.id.equalsExp(db.messageStates.contactId),
      ),
    ]);
    select.addColumns([db.messages.id]);
    select.where(Expression.and([
      db.messages.conversationId.equals(conversation.id),
      db.messageStates.checkedAt.isNull(),
      db.contacts.signPubkey.equals(scope.secret.signPubKey),
    ]));
    select.orderBy([
      OrderingTerm.asc(db.messages.createdAt),
    ]);
    select.limit(1);

    final record = await select.getSingleOrNull();
    return record?.read(db.messages.id) ?? -1;
  }

  Future<PortableMessage> createMessage() async {
    final message = PortableMessage()
      ..conversation = conversation.info
      ..uuid = const Uuid().v4()
      ..createdAt = Int64(
        DateTime.now().millisecondsSinceEpoch,
      )
      ..sender = scope.snapshot;

    final db = scope.db;
    final selectMember = db.conversationContacts.select().join([
      innerJoin(
        db.contacts,
        db.contacts.id.equalsExp(db.conversationContacts.contactId),
      ),
    ]);
    selectMember.where(
      db.conversationContacts.conversationId.equals(conversation.id),
    );
    final records = await selectMember.get();
    final members = records.map((e) => e.readTable(db.contacts));
    for (final member in members) {
      if (member.signPubkey == scope.secret.signPubKey) continue;
      final messageState = PortableMessageState()
        ..accountIndex = member.snapshot.index
        ..createdAt = message.createdAt;
      message.messageStates.add(messageState);
    }

    return message;
  }

  Future<void> sendMessage(
    List<PortableMessage> messages, {
    required bool toBottom,
  }) async {
    // 通过 ConversationAgent 加密消息内容
    final wrappers = <SignWrapper>[];
    final operations = <PortableOperation>[];
    var i = 0;
    for (final message in messages) {
      final agent = conversation.info.findAgent(scope);
      final secretBox = await CryptoUtils.encrypt(
        scope,
        agent,
        message.writeToBuffer(),
      );
      final buffer = secretBox.writeToBuffer();
      final signature = await CryptoUtils.createSignature(scope, buffer);
      final wrapper = SignWrapper()
        ..buffer = buffer
        ..signer = scope.snapshot.index
        ..sign = signature.bytes
        ..encrypt = true;
      wrappers.add(wrapper);
      final operation = await scope.operator.factory.message(
        wrapper,
        offset: i++,
      );
      operations.add(operation);
    }

    await _sendMessage(wrappers);
    await scope.operator.apply(operations);

    if (toBottom) {
      onUpdates.add(handleToBottom);
    }
  }

  Future<void> _sendMessage(List<SignWrapper> wrappers) async {
    final postData = FormData.fromMap({
      'data': jsonEncode(wrappers
          .map((wrapper) => base64Encode(wrapper.writeToBuffer()))
          .toList()),
    });
    if (conversation.type == ConversationType.CONVERSATION_PRIVATE) {
      final agent = conversation.info.findAgent(scope);
      final select = scope.db.contacts.select();
      select.where((tbl) => tbl.signPubkey.equals(agent.signPubKey));
      final contact = await select.getSingle();
      await Future.wait(contact.snapshot.serviceMap.keys.map(
        (e) => dio.post('$e/${contact.signPubkey}/messages', data: postData),
      ));
      return;
    }

    throw UnimplementedError();
  }

  final itemScrollController = ItemScrollController();
  final scrollOffsetController = ScrollOffsetController();
  final itemPositionListener = ItemPositionsListener.create();
  final scrollOffsetListener = ScrollOffsetListener.create();

  handleToBottom() {
    final index = ids.indexOf(-2);
    itemScrollController.scrollTo(
      index: index,
      duration: Durations.medium1,
      alignment: 1,
    );
  }

  handleToUncheck() {
    final index = ids.indexOf(-1);
    itemScrollController.scrollTo(
      index: index,
      duration: Durations.medium1,
      alignment: 1,
    );
  }

  @override
  void dispose() {
    idsSub?.cancel();
    uncheckSub?.cancel();
    super.dispose();
  }
}
