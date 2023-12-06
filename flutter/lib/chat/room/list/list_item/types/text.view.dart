import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/list/list_item/wrapper.view.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:styled_widget/styled_widget.dart';

class TextMessageView extends StatelessWidget {
  const TextMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    final message = context.watch<Message>();
    return MessageListItemWrapperView(
      child: SelectableText(message.content)
          .padding(all: 8)
          .center()
          .constrained(minWidth: 32, minHeight: 32),
    );
  }
}
