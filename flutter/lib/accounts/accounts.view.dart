import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/accounts/account_card/account_card.view.dart';
import 'package:sheason_chat/scope/scope.collection.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final collection = context.watch<ScopeCollection>();
    final scopes = collection.scopeMap.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('账号管理'),
      ),
      body: ListView.builder(
        itemCount: scopes.length,
        itemBuilder: (context, index) => AccountCard(
          scope: scopes[index],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: collection.handleCreateAccount,
        child: const Icon(Icons.add),
      ),
    );
  }
}
