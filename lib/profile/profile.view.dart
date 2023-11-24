import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheason_chat/profile/profile.controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            onTap: controller.handleExportReplica,
            title: const Text('创建账号副本'),
            subtitle: const Text('将账号复制到其他设备'),
          ),
          ListTile(
            onTap: () {},
            title: const Text('配置用户名'),
            subtitle: const Text('配置用户名'),
          ),
          ListTile(
            onTap: () {},
            title: const Text('修改头像'),
            subtitle: const Text('点击修改头像'),
          )
        ],
      ),
    );
  }
}
