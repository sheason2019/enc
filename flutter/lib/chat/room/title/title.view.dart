import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/extensions/portable_conversation/portable_conversation.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ChatRoomPageTitle extends StatelessWidget {
  const ChatRoomPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();
    final conversation = context.watch<Conversation>();
    if (conversation.type == ConversationType.CONVERSATION_PRIVATE) {
      final snapshot = conversation.info.findPrivateSnapshot(scope);
      return Text(snapshot.username);
    }

    throw UnimplementedError();
  }
}
