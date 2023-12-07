import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:styled_widget/styled_widget.dart';

class MessageListItemWrapperView extends StatelessWidget {
  final Widget child;
  const MessageListItemWrapperView({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final contact = context.watch<Contact>();
    final message = context.watch<Message>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar().padding(top: 6),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  contact.snapshot.username,
                  overflow: TextOverflow.ellipsis,
                ).bold().width(240),
                Text(
                  message.createdAt.toString(),
                  overflow: TextOverflow.ellipsis,
                ).expanded(),
              ],
            ),
            Row(
              children: [
                Card(
                  color: Colors.white,
                  elevation: 0,
                  child: child,
                ),
              ],
            ),
          ],
        ).padding(horizontal: 4).expanded(),
      ],
    );
  }
}
