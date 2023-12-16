import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/accounts/account_avatar.view.dart';
import 'package:sheason_chat/chat/message_debug/message_debug.view.dart';
import 'package:sheason_chat/chat/room/messages/message/progress.view.dart';
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
        AccountAvatar(
          snapshot: contact.snapshot,
        ).padding(top: 6),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              textDirection:
                  isCurrentAccountSend ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Text(
                  contact.snapshot.username,
                  overflow: TextOverflow.ellipsis,
                ).bold().constrained(maxWidth: 180),
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
              textDirection:
                  isCurrentAccountSend ? TextDirection.rtl : TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _MessageContentCard(child: child),
                const MessageStateProgressView(),
                const SizedBox(width: 40),
              ],
            ),
          ],
        ).padding(horizontal: 4).expanded(),
      ],
    );
  }
}

class _MessageContentCard extends StatefulWidget {
  final Widget child;
  const _MessageContentCard({required this.child});

  @override
  State<StatefulWidget> createState() => _MessageContentCardState();
}

class _MessageContentCardState extends State<_MessageContentCard> {
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

    final isCurrentAccountSend = contact.signPubkey == scope.secret.signPubKey;

    Offset? position;

    return MenuAnchor(
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
      ),
      anchorTapClosesMenu: true,
      builder: (context, controller, _) => GestureDetector(
        onLongPressStart: (details) => position = details.localPosition,
        onLongPress: () => controller.open(
          position: position,
        ),
        onSecondaryTapDown: (details) => controller.open(
          position: details.localPosition,
        ),
        child: Card(
          clipBehavior: Clip.hardEdge,
          color: isCurrentAccountSend ? Colors.blue : Colors.white,
          elevation: 0,
          child: widget.child,
        ),
      ),
    );
  }
}
