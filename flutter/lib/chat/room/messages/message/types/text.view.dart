import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/chat/room/messages/message/wrapper.view.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class TextMessageView extends StatelessWidget {
  const TextMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();
    final message = context.watch<Message>();
    final contact = context.watch<Contact>();

    final isCurrentAccountSend = contact.signPubkey == scope.secret.signPubKey;

    return MessageListItemWrapperView(
      child: Text(
        message.content,
        style: TextStyle(
          color: isCurrentAccountSend ? Colors.white : Colors.black,
        ),
        softWrap: true,
      ).constrained(maxWidth: 360).padding(horizontal: 12, vertical: 8),
    );
  }
}
