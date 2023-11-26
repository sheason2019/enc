import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/accounts/accounts.view.dart';
import 'package:sheason_chat/main.controller.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  toBarcodeScanner(BuildContext context) {}
  toAccounts(BuildContext context) {
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.add(const AccountsPage());
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('消息列表'),
        centerTitle: true,
        leading: Center(
          child: GestureDetector(
            onTap: () => toAccounts(context),
            child: const MouseRegion(
              cursor: SystemMouseCursors.click,
              child: CircleAvatar(),
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
    );
  }
}
