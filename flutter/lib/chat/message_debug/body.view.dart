import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/utils/string_helper.dart';

class MessageDebugPageBody extends StatelessWidget {
  const MessageDebugPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final message = context.watch<Message>();

    return ListView(
      children: [
        ListTile(
          title: const Text('Message Type'),
          subtitle: Text(message.messageType.name),
        ),
        ListTile(
          title: const Text('Message UUID'),
          subtitle: Text(message.uuid),
        ),
        ListTile(
          title: const Text('Message Content'),
          subtitle: Text(message.content),
        ),
        ListTile(
          title: const Text('Message CreatedAt'),
          subtitle: Text(StringHelper.time(message.createdAt)),
        ),
      ],
    );
  }
}
