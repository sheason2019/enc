import 'package:flutter/material.dart';
import 'package:sheason_chat/schema/database.dart';

class ChatRoomPage extends StatelessWidget {
  final Conversation conversation;
  const ChatRoomPage({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room Page. ID: ${conversation.id}'),
      ),
    );
  }
}
