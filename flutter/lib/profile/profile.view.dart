import 'package:ENC/main.controller.dart';
import 'package:ENC/router/base_delegate_wrapper.dart';
import 'package:ENC/utils/breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/profile/account_qrcode/account_qrcode.view.dart';
import 'package:ENC/profile/alter_avatar/alter_avatar.view.dart';
import 'package:ENC/profile/alter_username/alter_username.view.dart';
import 'package:ENC/profile/operations/operations.view.dart';
import 'package:ENC/replica/replica.view.dart';
import 'package:ENC/router/base_delegate.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

import 'services/services.view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();
    final bp = context.watch<BreakPoint>();
    if (bp == BreakPoint.lg) {
      return Row(
        children: [
          const _ProfileView().width(360),
          const VerticalDivider(
            width: 1,
            color: Colors.black12,
          ),
          BaseDelegateWrapper(
            delegate: scope.router.profileDelegate,
            child: const Scaffold(),
          ).expanded(),
        ],
      );
    }

    return const _ProfileView();
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  to(BaseDelegate delegate, Widget widget) {
    delegate.pages.clear();
    delegate.pages.add(widget);
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();
    final delegate = scope.router.profileDelegate;
    final rootDelegate = context.watch<MainController>().rootDelegate;

    return Scaffold(
      body: ListView(
        children: [
          const AlterAvatarWidget().center().padding(top: 48, bottom: 12),
          ListTile(
            onTap: () => to(delegate, const AlterUsernamePage()),
            title: Text(
              scope.snapshot.username,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
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
            onTap: () {
              rootDelegate.pages.add(ReplicaPage(
                dataDirection: ReplicaDataDirection.push,
                scope: context.read<Scope?>(),
              ));
              rootDelegate.notify();
            },
            title: const Text('将账号复制到其他设备'),
          ),
        ],
      ),
    );
  }
}
