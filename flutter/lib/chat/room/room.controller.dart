import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:sheason_chat/cyprto/crypto_keypair.dart';
import 'package:sheason_chat/cyprto/crypto_utils.dart';
import 'package:sheason_chat/dio.dart';
import 'package:sheason_chat/extensions/conversation/conversation.dart';
import 'package:sheason_chat/extensions/portable_conversation/portable_conversation.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:uuid/uuid.dart';

class ChatRoomController extends ChangeNotifier {
  final Scope scope;
  final Conversation conversation;

  final uploads = <Future>[];

  ChatRoomController({
    required this.scope,
    required this.conversation,
  });

  Future<void> sendMessage({
    required String content,
    required MessageType messageType,
  }) async {
    // 创建 PortableMessage
    final now = Int64(
      DateTime.now().millisecondsSinceEpoch,
    );
    final message = PortableMessage();
    message.messageType = messageType;
    message.content = content;
    message.conversation = await conversation.toPortableConversation(scope);
    message.uuid = const Uuid().v4();
    message.createdAt = now;
    message.sender = scope.snapshot;

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
      final messageState = PortableMessageState()
        ..accountIndex = member.snapshot.index
        ..createdAt = now;
      message.messageStates.add(messageState);
    }

    // 通过 ConversationAgent 加密消息内容
    final keypair = CryptoKeyPair.fromSecret(scope.secret);
    final agent = conversation.info.findAgent(scope);
    final secretBox = await CryptoUtils.encrypt(
      scope,
      agent,
      message.writeToBuffer(),
    );
    final buffer = secretBox.writeToBuffer();
    final signature = await CryptoUtils.createSignature(
      keypair,
      buffer,
    );
    final wrapper = SignWrapper()
      ..buffer = buffer
      ..signer = scope.snapshot.index
      ..sign = signature.bytes
      ..encrypt = true;

    await _sendMessage(wrapper);
    final operation = await scope.operator.factory.message(wrapper);
    await scope.operator.apply([operation]);

    notifyListeners();
  }

  Future<void> _sendMessage(SignWrapper wrapper) async {
    final postData = FormData.fromMap({
      'data': base64Encode(wrapper.writeToBuffer()),
    });
    if (conversation.type == ConversationType.CONVERSATION_PRIVATE) {
      final agent = conversation.info.findAgent(scope);
      final select = scope.db.contacts.select();
      select.where((tbl) => tbl.signPubkey.equals(agent.signPubKey));
      final contact = await select.getSingle();
      await Future.wait(contact.snapshot.serviceMap.keys.map((e) async {
        await dio.post('$e/${contact.signPubkey}/messages', data: postData);
      }));
      return;
    }

    throw UnimplementedError();
  }
}
