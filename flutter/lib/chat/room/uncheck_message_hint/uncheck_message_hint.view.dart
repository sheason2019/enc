import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/room/room.controller.dart';

class UncheckMessageHintFAB extends StatelessWidget {
  const UncheckMessageHintFAB({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ChatController>();

    return ValueListenableBuilder(
      valueListenable: controller.uncheckController,
      builder: (context, uncheck, _) => AnimatedScale(
        scale: uncheck == 0 ? 0 : 1,
        duration: Durations.short3,
        child: FloatingActionButton(
          heroTag: 'uncheck-hint',
          onPressed: controller.messagesController.handleToUncheck,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          backgroundColor: Colors.white,
          child: Badge.count(
            isLabelVisible: uncheck > 0,
            offset: const Offset(8, 8),
            alignment: Alignment.bottomRight,
            count: uncheck,
            child: const Icon(Icons.keyboard_arrow_down),
          ),
        ),
      ),
    );
  }
}
