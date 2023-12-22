import 'dart:async';

import 'package:drift/drift.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/chat/room/room.controller.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:synchronized/synchronized.dart';

class MessageChecker {
  final BuildContext context;

  ChatController get chatController => context.read<ChatController>();
  Scope get scope => context.read<Scope>();
  Conversation get conversation => context.read<Conversation>();

  MessageChecker({
    required this.context,
  });

  var _messageSet = <Message>{};
  Timer? timer;

  final _lock = Lock();

  static const duration = Durations.long2;

  void check(Message message) {
    // 重复写入问题
    timer ??= Timer(
      duration,
      () => _lock.synchronized(() => _proceed()),
    );

    _messageSet.add(message);
  }

  Future<void> _proceed() async {
    Message? maxMessage;
    final messageSet = _messageSet;
    _messageSet = {};
    timer = null;

    for (final message in messageSet) {
      maxMessage ??= message;
      if (message.createdAt.isAfter(maxMessage.createdAt)) {
        maxMessage = message;
      }
    }
    if (maxMessage == null) return;

    final db = scope.db;
    final select = db.messageStates.select().join(
      [
        innerJoin(
          db.contacts,
          db.contacts.id.equalsExp(db.messageStates.contactId),
        ),
        innerJoin(
          db.messages,
          db.messages.id.equalsExp(db.messageStates.messageId),
        ),
      ],
    );
    select.where(db.contacts.signPubkey.equals(scope.secret.signPubKey));
    select.where(db.messages.conversationId.equals(conversation.id));
    select.where(db.messageStates.checkedAt.isNull());
    select.where(
      db.messages.createdAt.isSmallerOrEqualValue(maxMessage.createdAt),
    );
    final records = await select.get();
    if (records.isEmpty) return;

    final portableDatas = <PortableMessage>[];
    for (final record in records) {
      final messageState = record.readTable(db.messageStates);
      // create portable message
      final portable = PortableMessage()
        ..messageType = MessageType.MESSAGE_TYPE_STATE_ONLY
        ..uuid = record.read(db.messages.uuid)!
        ..sender = scope.snapshot
        ..createdAt = Int64(DateTime.now().millisecondsSinceEpoch)
        ..conversation = conversation.info
        ..messageStates.add(
          PortableMessageState()
            ..accountIndex = scope.snapshot.index
            ..createdAt = Int64(
              messageState.createdAt?.millisecondsSinceEpoch ?? 0,
            )
            ..receiveAt = Int64(
              messageState.receiveAt?.millisecondsSinceEpoch ?? 0,
            )
            ..checkedAt = Int64(
              DateTime.now().millisecondsSinceEpoch,
            ),
        );
      portableDatas.add(portable);
    }

    await chatController.inputController.sendMessage(portableDatas);
  }
}
