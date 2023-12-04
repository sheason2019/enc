import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/room.view.dart';
import 'package:sheason_chat/extensions/portable_conversation/portable_conversation.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ConversationAnchorListTile extends StatelessWidget {
  final int conversationid;
  const ConversationAnchorListTile({
    super.key,
    required this.conversationid,
  });

  Future<Conversation> findConversation(BuildContext context) {
    final scope = context.read<Scope>();
    final select = scope.db.conversations.select();
    select.where((tbl) => tbl.id.equals(conversationid));
    return select.getSingle();
  }

  Future<void> handleClick(
    BuildContext context,
    Conversation conversation,
  ) async {
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.add(ChatRoomPage(conversation: conversation));
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();

    return FutureBuilder(
      future: findConversation(context),
      builder: (context, snapshot) {
        var title = '';
        var subtitle = '';
        if (snapshot.hasData) {
          final conversation = snapshot.data!;
          if (conversation.type == ConversationType.CONVERSATION_PRIVATE) {
            final snapshot = conversation.info.findPrivateSnapshot(scope);
            title = snapshot.username;
            subtitle = snapshot.index.signPubKey;
          }
        }

        return ListTile(
          onTap: () => handleClick(context, snapshot.data!),
          leading: const CircleAvatar(),
          title: Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            subtitle,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}
