import 'package:ENC/router/base_delegate_wrapper.dart';
import 'package:ENC/utils/breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/chat/anchors/anchors.view.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();
    final bp = context.watch<BreakPoint>();

    if (bp == BreakPoint.lg) {
      return Scaffold(
        body: Row(
          children: [
            const ConversationAnchorsView().width(360),
            const VerticalDivider(
              width: 1,
              color: Colors.black12,
            ),
            BaseDelegateWrapper(
              delegate: scope.router.chatDelegate,
              child: const Scaffold(),
            ).expanded(),
          ],
        ),
      );
    }

    return const ConversationAnchorsView();
  }
}
