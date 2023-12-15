import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/accounts/account_list_tile/account_list_tile.view.dart';
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
        itemBuilder: (context, index) => AccountListTile(
          scope: scopes[index],
        ),
      ),
      endDrawer: NavigationDrawer(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, bottom: 8, top: 16),
            child: Text(
              '新建账号',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
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
