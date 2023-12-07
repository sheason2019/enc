import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/chat/message_debug/message_debug.view.dart';
import 'package:sheason_chat/chat/room/list/list_item/progress.view.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:sheason_chat/utils/string_helper.dart';
import 'package:styled_widget/styled_widget.dart';

class MessageListItemWrapperView extends StatelessWidget {
  final Widget child;
  const MessageListItemWrapperView({
    super.key,
    required this.child,
  });

  toDebugPage(BuildContext context) {
    final delegate = context.read<MainController>().rootDelegate;
    final message = context.read<Message>();

    delegate.pages.add(MessageDebugPage(message: message));
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();
    final contact = context.watch<Contact>();
    final message = context.watch<Message>();

    final isCurrentAccountSend = contact.signPubkey == scope.secret.signPubKey;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: isCurrentAccountSend
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      textDirection:
          isCurrentAccountSend ? TextDirection.rtl : TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar().padding(top: 6),
        IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                textDirection: isCurrentAccountSend
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                children: [
                  Text(
                    contact.snapshot.username,
                    overflow: TextOverflow.ellipsis,
                  ).bold().width(180),
                  Text(
                    StringHelper.time(message.createdAt),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                    textAlign:
                        isCurrentAccountSend ? TextAlign.right : TextAlign.left,
                  ).padding(horizontal: 4).expanded(),
                ],
              ),
              Row(
                textDirection: isCurrentAccountSend
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MenuAnchor(
                    menuChildren: [
                      MenuItemButton(
                        onPressed: () => toDebugPage(context),
                        child: const Text(
                          '查看调试信息',
                        ),
                      ),
                    ],
                    style: const MenuStyle(
                        visualDensity: VisualDensity.comfortable,
                        alignment: FractionalOffset(0, -1.25)),
                    anchorTapClosesMenu: true,
                    builder: (context, controller, _) => GestureDetector(
                      onLongPress: () => controller.open(),
                      onSecondaryTapDown: (details) => controller.open(
                        position: details.localPosition,
                      ),
                      child: Card(
                        color:
                            isCurrentAccountSend ? Colors.blue : Colors.white,
                        elevation: 0,
                        child: child,
                      ),
                    ),
                  ),
                  const MessageStateProgressView(),
                ],
              ),
            ],
          ),
        ).padding(horizontal: 4).expanded(),
      ],
    );
  }
}
