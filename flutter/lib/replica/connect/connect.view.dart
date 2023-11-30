import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/replica/proceed/proceed.view.dart';
import 'package:sheason_chat/replica/replica.view.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ReplicaConnectPage extends StatefulWidget {
  final Scope? scope;
  final ReplicaDataDirection dataDirection;
  const ReplicaConnectPage({
    super.key,
    required this.dataDirection,
    required this.scope,
  });

  @override
  State<StatefulWidget> createState() => _ReplicaConnectPageState();
}

class _ReplicaConnectPageState extends State<ReplicaConnectPage> {
  final urlController = TextEditingController();
  final nsController = TextEditingController();

  @override
  void dispose() {
    urlController.dispose();
    nsController.dispose();
    super.dispose();
  }

  handleSubmit() {
    final url = urlController.text;
    final ns = nsController.text;

    final scope = context.read<Scope?>();
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.add(
      ReplicaProceedPage(
        url: url,
        scope: scope,
        namespace: ns,
        dataDirection: widget.dataDirection,
        connDirection: ReplicaConnDirection.connect,
      ),
    );
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    final showQrScan = Platform.isAndroid || Platform.isIOS;

    return Scaffold(
      appBar: AppBar(
        title: const Text('复制账号'),
      ),
      body: Center(
        child: SizedBox(
          width: 360,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(label: Text('URL')),
                controller: urlController,
              ),
              TextField(
                decoration: const InputDecoration(label: Text('连接码')),
                controller: nsController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: FilledButton(
                  onPressed: handleSubmit,
                  child: const Text('连接'),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: showQrScan
          ? FloatingActionButton.extended(
              onPressed: () {},
              label: const Text('扫一扫'),
              icon: const Icon(Icons.qr_code_scanner),
            )
          : null,
    );
  }
}
