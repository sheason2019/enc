import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/accounts/account_avatar.view.dart';
import 'package:sheason_chat/accounts/accounts.view.dart';
import 'package:sheason_chat/accounts/online_hint/scope_online_hint.view.dart';
import 'package:sheason_chat/barcode/scanner/scanner.view.dart';
import 'package:sheason_chat/chat/anchors/anchors.view.dart';
import 'package:sheason_chat/chat/create_group/create_group.view.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  void toBarcodeScanner(BuildContext context) {
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.add(const BarcodeScannerPage());
    delegate.notify();
  }

  void toCreateGroup(BuildContext context) {
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.add(const CreateGroupPage());
    delegate.notify();
  }

  toAccounts(BuildContext context) {
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.add(const AccountsPage());
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();

    final allowScan = Platform.isAndroid || Platform.isIOS;

    return Scaffold(
      appBar: AppBar(
        title: const Text('消息列表'),
        centerTitle: true,
        leading: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => toAccounts(context),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: AccountAvatar(
                  snapshot: scope.snapshot,
                ),
              ),
            ),
            ScopeOnlineHint(scope: scope).padding(left: 8),
          ],
        ).center().padding(horizontal: 16),
        leadingWidth: 144,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: PopupMenuButton<int>(
              onSelected: (v) {
                switch (v) {
                  case 0:
                    return toBarcodeScanner(context);
                  case 1:
                    return toCreateGroup(context);
                }
              },
              itemBuilder: (context) => [
                if (allowScan)
                  const PopupMenuItem(
                    value: 0,
                    child: Text('扫一扫'),
                  ),
                const PopupMenuItem(
                  value: 1,
                  child: Text('创建群聊'),
                ),
              ],
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: const ConversationAnchorsView(),
    );
  }
}
