import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/profile/services/detail/resource/resource.view.dart';
import 'package:sheason_chat/profile/services/detail/reupload_account_snapshot/reupload_account_snapshot.view.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ServiceDetailPage extends StatelessWidget {
  final String url;
  const ServiceDetailPage({super.key, required this.url});

  to(BuildContext context, Widget widget) {
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.add(widget);
    delegate.notify();
  }

  handleDeleteService(BuildContext context) async {
    final delegate = context.read<MainController>().rootDelegate;
    final scope = context.read<Scope>();
    // show confirm dialog
    final confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('警告'),
        content: const Text('确认删除此服务器吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              '确认删除',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    final operation = await scope.operator.factory.deleteService(url);
    await scope.operator.apply([operation], isReplay: false);

    delegate.pages.removeLast();
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(url),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () => to(context, ServiceResourcePage(url: url)),
            title: const Text('资源使用情况'),
            subtitle: const Text('查看服务器资源用量及限额'),
          ),
          ReloadAccountSnapshotListTile(url: url),
          ListTile(
            onTap: () => handleDeleteService(context),
            title: const Text(
              '删除此服务器',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
