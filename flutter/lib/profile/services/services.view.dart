import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/profile/services/create/create.view.dart';
import 'package:sheason_chat/profile/services/detail/detail.view.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  toDetail(BuildContext context, String url) {
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.add(ServiceDetailPage(url: url));
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    final snapshot = context.select<Scope, AccountSnapshot>(
      (scope) => scope.snapshot,
    );
    final serviceUrls = snapshot.serviceMap.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('正在使用的服务器'),
        actions: [
          TextButton(
            onPressed: () {
              final delegate = context.read<MainController>().rootDelegate;
              delegate.pages.add(const CreateServicePage());
              delegate.notify();
            },
            child: const Text('新建'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: serviceUrls.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () => toDetail(context, serviceUrls[index]),
          title: Text(serviceUrls[index]),
        ),
      ),
    );
  }
}
