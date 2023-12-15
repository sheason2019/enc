import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/profile/account_qrcode/account_qrcode.view.dart';
import 'package:sheason_chat/profile/alter_avatar/alter_avatar.view.dart';
import 'package:sheason_chat/profile/alter_username/alter_username.view.dart';
import 'package:sheason_chat/profile/operations/operations.view.dart';
import 'package:sheason_chat/replica/replica.view.dart';
import 'package:sheason_chat/router/base_delegate.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

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
          const AlterAvatarWidget().center().padding(top: 48, bottom: 12),
          ListTile(
            onTap: () => to(delegate, const AlterUsernamePage()),
            title: Text(
              scope.snapshot.username,
              textAlign: TextAlign.center,
            ),
            subtitle: const Text(
              '点击修改用户名',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ).padding(bottom: 36),
          ListTile(
            onTap: () => to(delegate, const ServicesPage()),
            title: const Text('服务器配置'),
            subtitle: Text(
              '${scope.snapshot.serviceMap.length} 个正在使用的服务器',
            ),
          ),
          ListTile(
            onTap: () => to(delegate, const AccountQrCodePage()),
            title: const Text('账号二维码'),
          ),
          ListTile(
            onTap: () => to(delegate, const OperationsPage()),
            title: const Text('查看操作日志'),
          ),
          ListTile(
            onTap: () => to(
              delegate,
              ReplicaPage(
                dataDirection: ReplicaDataDirection.push,
                scope: context.read<Scope?>(),
              ),
            ),
            title: const Text('将账号复制到其他设备'),
          ),
        ],
      ),
    );
  }
}
