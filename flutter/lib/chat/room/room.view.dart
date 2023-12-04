import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/extensions/conversation/conversation.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ChatRoomPage extends StatefulWidget {
  final Conversation conversation;
  const ChatRoomPage({super.key, required this.conversation});

  @override
  State<StatefulWidget> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  handleTriggerAnchor() async {
    // 查询 Anchor 中是否存在此会话，若不存在则创建 Anchor
    final scope = context.read<Scope>();
    final index = scope.anchor.list.indexOf(widget.conversation.id);
    if (index == -1) {
      final portable = await widget.conversation.toPortableConversation(
        scope,
      );
      final operation = await scope.operator.createOperation(jsonEncode({
        'type': 'conversation-anchor/put',
        'payload': {
          'conversation': base64Encode(portable.writeToBuffer()),
        },
      }));
      await scope.operator.apply([operation]);
    }
  }

  @override
  void initState() {
    handleTriggerAnchor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room Page. ID: ${widget.conversation.id}'),
      ),
    );
  }
}
