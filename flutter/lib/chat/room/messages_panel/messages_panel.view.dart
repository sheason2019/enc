import 'package:flutter/material.dart';
import 'package:sheason_chat/chat/room/messages/messages.view.dart';
import 'package:sheason_chat/chat/room/uncheck_message_hint/uncheck_message_hint.view.dart';

class MessagesPanelView extends StatelessWidget {
  const MessagesPanelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.05),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: const MessagesView(),
      ),
      floatingActionButton: const UncheckMessageHintFAB(),
    );
  }
}
