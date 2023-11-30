import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/accounts/account_card/account_card.view.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/replica/replica.view.dart';
import 'package:sheason_chat/scope/scope.collection.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final collection = context.watch<ScopeCollection>();
    final scopes = collection.scopeMap.values.toList();

    final key = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: key,
      appBar: AppBar(
        title: const Text('账号管理'),
        actions: const [
          SizedBox.shrink(),
        ],
      ),
      body: ListView.builder(
        itemCount: scopes.length,
        itemBuilder: (context, index) => AccountCard(
          scope: scopes[index],
        ),
      ),
      endDrawer: NavigationDrawer(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8, top: 16),
            child: Text(
              '新建账号',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            onTap: () async {
              await collection.createScope();
              key.currentState?.closeEndDrawer();
            },
            title: const Text('新建随机账号'),
          ),
          ListTile(
            onTap: () {
              final delegate = context.read<MainController>().rootDelegate;
              delegate.pages.add(const ReplicaPage(
                dataDirection: ReplicaDataDirection.pull,
                scope: null,
              ));
              delegate.notify();
              key.currentState?.closeEndDrawer();
            },
            title: const Text('从其他设备导入账号'),
          ),
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () => key.currentState?.openEndDrawer(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
