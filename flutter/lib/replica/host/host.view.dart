import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/replica/proceed/proceed.view.dart';
import 'package:sheason_chat/replica/replica.view.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class ReplicaHostPage extends StatefulWidget {
  final Scope? scope;
  final ReplicaDataDirection dataDirection;
  const ReplicaHostPage({
    super.key,
    required this.scope,
    required this.dataDirection,
  });
  @override
  State<StatefulWidget> createState() => _ReplicaHostPageState();
}

class _ReplicaHostPageState extends State<ReplicaHostPage> {
  String? serviceUrl;
  final textController = TextEditingController();

  handleSubmit() {
    final delegate = context.read<MainController>().rootDelegate;
    late String serviceUrl;
    if (this.serviceUrl == 'hand-input') {
      serviceUrl = textController.text;
    } else {
      serviceUrl = this.serviceUrl ?? '';
    }
    if (serviceUrl == '') {
      throw Exception('Service url cannot be null');
    }

    delegate.pages.add(ReplicaProceedPage(
      scope: widget.scope,
      url: serviceUrl,
      namespace: null,
      dataDirection: widget.dataDirection,
      connDirection: ReplicaConnDirection.host,
    ));
    delegate.notify();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final services = widget.scope?.snapshot.serviceMap.keys.toList() ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('复制账号'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('选择服务器').padding(bottom: 12),
          DropdownButton<String>(
            isExpanded: true,
            value: serviceUrl,
            onChanged: (v) {
              setState(() {
                serviceUrl = v;
              });
            },
            items: [
              for (final service in services)
                DropdownMenuItem(
                  value: service,
                  child: Text(service),
                ),
              const DropdownMenuItem(
                value: 'hand-input',
                child: Text('手动输入URL'),
              ),
            ],
          ),
          if (serviceUrl == 'hand-input')
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                label: Text('输入 URL'),
              ),
            ),
          FilledButton(
            onPressed: handleSubmit,
            child: const Text('下一步'),
          ).padding(vertical: 8),
        ],
      ).width(360).center(),
    );
  }
}
