import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/list/list_item/wrapper.view.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';
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
      child: SelectableText(
        message.content,
        cursorWidth: 0,
        style: TextStyle(
          color: isCurrentAccountSend ? Colors.white : Colors.black,
        ),
      )
          .center()
          .padding(horizontal: 12)
          .constrained(minWidth: 36, minHeight: 36),
    );
  }
}
