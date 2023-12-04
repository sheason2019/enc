import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/room.view.dart';
import 'package:sheason_chat/extensions/portable_conversation/portable_conversation.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ContactDetailPage extends StatelessWidget {
  final AccountSnapshot snapshot;
  const ContactDetailPage({super.key, required this.snapshot});

  Future<Conversation> putConversation(BuildContext context) async {
    final scope = context.read<Scope>();

    final portable = PortableConversation()
      ..type = ConversationType.CONVERSATION_PRIVATE
      ..members.addAll({
        scope.snapshot.index.signPubKey: scope.snapshot,
        snapshot.index.signPubKey: snapshot,
      }.values);
    final agent = portable.findAgent(scope);
    final select = scope.db.conversations.select();
    select.where(
      (tbl) => tbl.type.equalsValue(ConversationType.CONVERSATION_PRIVATE),
    );
    select.where((tbl) => tbl.signPubkey.equals(agent.signPubKey));
    var conversation = await select.getSingleOrNull();
    if (conversation != null) {
      return conversation;
    }

    final operation = await scope.operator.createOperation(jsonEncode({
      'type': 'conversation/put',
      'payload': {
        'conversation': base64Encode(portable.writeToBuffer()),
      },
    }));
    await scope.operator.apply([operation]);
    return select.getSingle();
  }

  toPrivateConversation(BuildContext context) async {
    final delegate = context.read<MainController>().rootDelegate;
    final conversation = await putConversation(context);
    delegate.pages.removeRange(1, delegate.pages.length);
    delegate.pages.add(ChatRoomPage(conversation: conversation));
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('用户详情'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(),
            title: Text(
              snapshot.username,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              snapshot.index.signPubKey,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            onTap: () => toPrivateConversation(context),
            title: const Text('发起会话'),
          ),
        ],
      ),
    );
  }
}
