import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/extensions/portable_conversation/portable_conversation.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ChatRoomPageTitle extends StatelessWidget {
  const ChatRoomPageTitle({super.key});

  Stream<String> watchUsername(Scope scope, AccountIndex agent) {
    final select = scope.db.contacts.select();
    select.where((tbl) => tbl.signPubkey.equals(agent.signPubKey));
    return select.watchSingle().map((contact) {
      final username = contact.snapshot.username;
      if (username.isEmpty) return agent.signPubKey;

      return username;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();
    final conversation = context.watch<Conversation>();
    if (conversation.type == ConversationType.CONVERSATION_PRIVATE) {
      final agent = conversation.info.findAgent(scope);

      return StreamBuilder<String>(
        initialData: agent.signPubKey,
        stream: watchUsername(scope, agent),
        builder: (context, snapshot) => Text(snapshot.requireData),
      );
    }

    throw UnimplementedError();
  }
}
