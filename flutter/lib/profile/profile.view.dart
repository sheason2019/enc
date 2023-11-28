import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/profile/alter_username/alter_username.view.dart';
import 'package:sheason_chat/profile/operations/operations.view.dart';
import 'package:sheason_chat/replica/export/export.view.dart';
import 'package:sheason_chat/router/base_delegate.dart';
import 'package:sheason_chat/scope/scope.model.dart';

import 'services/services.view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  to(BaseDelegate delegate, Widget widget) {
    delegate.pages.add(widget);
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();
    final delegate = context.watch<MainController>().rootDelegate;

    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            onTap: () => to(delegate, const ExportReplicaPage()),
            title: const Text('创建账号副本'),
            subtitle: const Text('将账号复制到其他设备'),
          ),
          ListTile(
            onTap: () => to(delegate, const AlterUsernamePage()),
            title: const Text('配置用户名'),
            subtitle: Text(scope.snapshot.username),
          ),
          ListTile(
            onTap: () => to(delegate, const ServicesPage()),
            title: const Text('服务器配置'),
            subtitle: Text(
              '${scope.snapshot.serviceMap.length} 个正在使用的服务器',
            ),
          ),
          ListTile(
            onTap: () {},
            title: const Text('修改头像'),
            subtitle: const Text('点击修改头像'),
          ),
          ListTile(
            onTap: () => to(delegate, const OperationsPage()),
            title: const Text('Operation Chain'),
            subtitle: const Text('查看同步操作链'),
          ),
        ],
      ),
    );
  }
}
