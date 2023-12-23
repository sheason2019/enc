import 'dart:io';

import 'package:ENC/accounts/online_hint/scope_online_hint.view.dart';
import 'package:ENC/barcode/scanner/scanner.view.dart';
import 'package:ENC/chat/create_group/create_group.view.dart';
import 'package:ENC/main.controller.dart';
import 'package:ENC/scope/layout/account_collection_entry/account_collection_entry.view.dart';
import 'package:ENC/utils/breakpoint/breakpoint.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/chat/anchors/anchor/anchor.view.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class ConversationAnchorsView extends StatelessWidget {
  const ConversationAnchorsView({super.key});

  Stream<Conversation> fetchConversation(
    BuildContext context,
    int id,
  ) {
    final scope = context.watch<Scope>();
    final select = scope.db.conversations.select();
    select.where((tbl) => tbl.id.equals(id));
    return select.watchSingle();
  }

  void toBarcodeScanner(BuildContext context) {
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.add(const BarcodeScannerPage());
    delegate.notify();
  }

  void toCreateGroup(BuildContext context) {
    final delegate = context.read<Scope>().router.chatDelegate;
    delegate.pages.clear();
    delegate.pages.add(const CreateGroupPage());
    delegate.notify();
  }

  Widget? accountCollectionEntryBuilder(BuildContext context) {
    final scope = context.watch<Scope>();
    final bp = context.watch<BreakPoint>();

    if (bp == BreakPoint.lg) {
      return null;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const AccountCollectionEntry(),
        ScopeOnlineHint(scope: scope).padding(left: 8),
      ],
    ).center().padding(horizontal: 16);
  }

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();
    final allowScan = Platform.isAndroid || Platform.isIOS;

    final list = scope.anchor.list;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '消息列表',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: accountCollectionEntryBuilder(context),
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
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => StreamBuilder(
          stream: fetchConversation(context, list[index]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox.shrink();
            }

            return ConversationAnchorListTile(
              conversation: snapshot.requireData,
            );
          },
        ),
      ),
    );
  }
}
