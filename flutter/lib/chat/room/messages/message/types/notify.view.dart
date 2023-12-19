import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:styled_widget/styled_widget.dart';

class NotifyMessageView extends StatelessWidget {
  const NotifyMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    final message = context.watch<Message>();

    final json = jsonDecode(message.content);
    final type = json['type'];

    return Builder(
      builder: (context) {
        switch (type) {
          case 'create':
            return _CreateConversation(
              signPubkey: json['payload'],
            );
          default:
            return Text(message.content);
        }
      },
    ).center().padding(horizontal: 12, vertical: 8);
  }
}

class _CreateConversation extends StatelessWidget {
  final String signPubkey;
  const _CreateConversation({required this.signPubkey});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black),
        children: [
          TextSpan(text: signPubkey),
          const TextSpan(text: '创建了群聊'),
        ],
      ),
    );
  }
}
