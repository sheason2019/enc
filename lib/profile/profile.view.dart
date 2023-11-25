import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheason_chat/profile/alter_username/alter_username.view.dart';
import 'package:sheason_chat/profile/operations/operations.view.dart';
import 'package:sheason_chat/replica/export/export.view.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = Get.find<Scope>();

    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            onTap: () => Get.to(() => const ExportReplicaPage()),
            title: const Text('创建账号副本'),
            subtitle: const Text('将账号复制到其他设备'),
          ),
          ListTile(
            onTap: () => Get.to(() => AlterUsernamePage(scope: scope)),
            title: const Text('配置用户名'),
            subtitle: const Text('配置用户名'),
          ),
          ListTile(
            onTap: () {},
            title: const Text('修改头像'),
            subtitle: const Text('点击修改头像'),
          ),
          ListTile(
            onTap: () => Get.to(() => const OperationsPage()),
            title: const Text('Operation Chain'),
            subtitle: const Text('查看同步操作链'),
          ),
        ],
      ),
    );
  }
}
