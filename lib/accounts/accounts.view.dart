import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheason_chat/accounts/account_card/account_card.view.dart';
import 'package:sheason_chat/accounts/accounts.controller.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('账号管理'),
      ),
      body: Obx(() {
        final scopes = controller.scopeMap.values.toList();
        return ListView.builder(
          itemCount: scopes.length,
          itemBuilder: (context, index) => AccountCard(
            scope: scopes[index],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.handleCreateAccount,
        child: const Icon(Icons.add),
      ),
    );
  }
}
