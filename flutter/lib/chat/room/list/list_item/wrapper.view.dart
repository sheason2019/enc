import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class MessageListItemWrapperView extends StatelessWidget {
  final Widget child;
  const MessageListItemWrapperView({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(),
        Card(
          color: Colors.white,
          elevation: 0,
          child: child,
        ).padding(horizontal: 4),
      ],
    );
  }
}
