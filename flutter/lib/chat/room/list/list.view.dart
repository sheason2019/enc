import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sheason_chat/chat/room/list/list_item/list_item.view.dart';
import 'package:sheason_chat/chat/room/room.controller.dart';
import 'package:styled_widget/styled_widget.dart';

class MessageListView extends StatelessWidget {
  const MessageListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ChatController>();

    if (!controller.inited) return Container();

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final messages = controller.ids;

        return Scaffold(
          backgroundColor: Colors.black.withOpacity(0.05),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ScrollablePositionedList.builder(
              itemScrollController: controller.itemScrollController,
              scrollOffsetController: controller.scrollOffsetController,
              itemPositionsListener: controller.itemPositionListener,
              scrollOffsetListener: controller.scrollOffsetListener,
              itemCount: messages.length,
              initialScrollIndex: messages.indexOf(-1),
              initialAlignment: 1,
              minCacheExtent: 1440,
              itemBuilder: (context, index) {
                final message = messages[index];
                if ([-1, -2].contains(message)) return const SizedBox.shrink();

                return MessageListItemView(
                  messageId: message,
                ).padding(vertical: 8, horizontal: 12);
              },
            ),
          ),
          floatingActionButton: AnimatedScale(
            scale: controller.uncheck == 0 ? 0 : 1,
            duration: Durations.short3,
            child: FloatingActionButton(
              heroTag: 'uncheck-hint',
              onPressed: controller.handleToUncheck,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
              backgroundColor: Colors.white,
              child: Badge.count(
                isLabelVisible: controller.uncheck > 0,
                offset: const Offset(8, 8),
                alignment: Alignment.bottomRight,
                count: controller.uncheck,
                child: const Icon(Icons.keyboard_arrow_down),
              ),
            ),
          ),
        );
      },
    );
  }
}
