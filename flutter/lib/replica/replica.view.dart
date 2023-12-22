import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/main.controller.dart';
import 'package:ENC/replica/connect/connect.view.dart';
import 'package:ENC/replica/host/host.view.dart';
import 'package:ENC/router/base_delegate.dart';
import 'package:ENC/scope/scope.model.dart';

enum ReplicaDataDirection {
  push, // 将账号复制到其他设备
  pull, // 从其他设备复制账号
}

enum ReplicaConnDirection {
  host,
  connect,
}

class ReplicaPage extends StatelessWidget {
  final Scope? scope;
  final ReplicaDataDirection dataDirection;
  const ReplicaPage({
    super.key,
    required this.scope,
    required this.dataDirection,
  });

  toHost(BaseDelegate delegate) {
    delegate.pages.add(ReplicaHostPage(
      dataDirection: dataDirection,
      scope: scope,
    ));
    delegate.notify();
  }

  toConnect(BaseDelegate delegate) {
    delegate.pages.add(ReplicaConnectPage(
      dataDirection: dataDirection,
      scope: scope,
    ));
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    final delegate = context.read<MainController>().rootDelegate;

    return Scaffold(
      appBar: AppBar(
        title: const Text('账号复制'),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () => toHost(delegate),
            title: const Text('生成连接码'),
          ),
          ListTile(
            onTap: () => toConnect(delegate),
            title: const Text('输入连接码'),
          )
        ],
      ),
    );
  }
}
