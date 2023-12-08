import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/accounts/account_avatar.view.dart';
import 'package:sheason_chat/accounts/accounts.view.dart';
import 'package:sheason_chat/barcode/scanner/scanner.view.dart';
import 'package:sheason_chat/chat/anchors/anchors.view.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  toBarcodeScanner(BuildContext context) {
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.add(const BarcodeScannerPage());
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('消息列表'),
        centerTitle: true,
        leading: Center(
          child: GestureDetector(
            onTap: () => toAccounts(context),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: AccountAvatar(
                snapshot: scope.snapshot,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: PopupMenuButton<int>(
              onSelected: (v) {
                switch (v) {
                  case 0:
                    toBarcodeScanner(context);
                    return;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 0,
                  child: Text('扫一扫'),
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
