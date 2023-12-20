import 'package:flutter/material.dart';
import 'package:sheason_chat/chat/room/conversation_setting/group/group.view.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';

class ConversationSettingPage extends StatelessWidget {
  final Conversation conversation;
  const ConversationSettingPage({
    super.key,
    required this.conversation,
  });

  Widget titleBuilder(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('会话设置'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          if (conversation.type == ConversationType.CONVERSATION_GROUP)
            GroupSettings(conversation: conversation),
        ],
      ),
    );
  }
}
