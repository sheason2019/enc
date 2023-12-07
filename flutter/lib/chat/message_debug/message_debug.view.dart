import 'package:flutter/material.dart';
import 'package:sheason_chat/schema/database.dart';

class MessageDebugPage extends StatelessWidget {
  final Message message;
  const MessageDebugPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Debug Page'),
      ),
    );
  }
}
