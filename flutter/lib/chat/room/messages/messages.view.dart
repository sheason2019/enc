import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sheason_chat/chat/room/messages/message/message.view.dart';
import 'package:sheason_chat/chat/room/room.controller.dart';
import 'package:styled_widget/styled_widget.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ChatController>();
    final messagesController = controller.messagesController;

    return ListenableBuilder(
      listenable: messagesController,
      builder: (context, _) {
        if (!messagesController.inited) return const SizedBox();

        return ScrollablePositionedList.builder(
          initialAlignment: 1,
          initialScrollIndex: messagesController.uncheckIndex,
          itemScrollController: messagesController.itemScrollController,
          scrollOffsetController: messagesController.scrollOffsetController,
          scrollOffsetListener: messagesController.scrollOffsetListener,
          itemPositionsListener: messagesController.itemPositionListener,
          itemCount: messagesController.ids.length,
          itemBuilder: (context, index) {
            final id = messagesController.ids[index];
            if (id < 0) {
              return const SizedBox();
            }

            return MessageListItemView(
              messageId: id,
            );
          },
        );
      },
    ).padding(horizontal: 16);
  }
}
