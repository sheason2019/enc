import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/dio.dart';
import 'package:ENC/extensions/portable_conversation/portable_conversation.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:ENC/utils/sign_helper.dart';
import 'package:uuid/uuid.dart';

class MessageInputController extends ChangeNotifier {
  final BuildContext context;

  Scope get scope => context.read<Scope>();
  Conversation get conversation => context.read<Conversation>();

  MessageInputController({
    required this.context,
  });

  bool get useTextInput => _useTextInput;
  set useTextInput(bool value) {
    _useTextInput = value;
    notifyListeners();
  }

  var _useTextInput = true;

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

  Future<void> sendMessage(List<PortableMessage> messages) async {
    // 通过 ConversationAgent 加密消息内容
    final wrappers = <SignWrapper>[];
    final operations = <PortableOperation>[];
    for (final message in messages) {
      final agent = conversation.info.findAgent(scope);
      final wrapper = await SignHelper.wrap(
        scope,
        message.writeToBuffer(),
        encryptTarget: agent,
        contentType: ContentType.CONTENT_MESSAGE,
      );
      wrappers.add(wrapper);
      final operation = await scope.operator.factory.message(wrapper);
      operations.add(operation);
    }

    await _sendMessage(wrappers);
    await scope.operator.apply(operations, isReplay: false);
  }

  Future<void> _sendMessage(List<SignWrapper> wrappers) async {
    final postData = FormData.fromMap({
      'data': jsonEncode(wrappers
          .map((wrapper) => base64Encode(wrapper.writeToBuffer()))
          .toList()),
      'receivers': jsonEncode([conversation.signPubkey]),
    });
    if (conversation.type == ConversationType.CONVERSATION_PRIVATE) {
      final select = scope.db.contacts.select();
      select.where((tbl) => tbl.signPubkey.equals(conversation.signPubkey));
      final contact = await select.getSingle();
      await Future.wait(contact.snapshot.serviceMap.keys.map(
        (e) => dio.post('$e/message', data: postData),
      ));
      return;
    }

    if (conversation.type == ConversationType.CONVERSATION_GROUP) {
      final url = conversation.info.remoteUrl;
      final id = conversation.info.agent.signPubKey;
      await dio.post('$url/group/$id/message', data: postData);
      return;
    }

    throw UnimplementedError();
  }
}
