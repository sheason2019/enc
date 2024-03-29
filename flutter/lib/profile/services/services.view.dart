import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/accounts/online_hint/online_hint.view.dart';
import 'package:ENC/profile/services/create/create.view.dart';
import 'package:ENC/profile/services/detail/detail.view.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

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
              final scope = context.read<Scope>();
              final delegate = scope.router.profileDelegate;
              delegate.pages.add(const CreateServicePage());
              delegate.notify();
            },
            child: const Text('新建'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: serviceUrls.length,
        itemBuilder: (context, index) => _ServiceItem(
          serviceUrl: serviceUrls[index],
        ),
      ),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  final String serviceUrl;
  const _ServiceItem({required this.serviceUrl});

  toDetail(BuildContext context) {
    final delegate = context.read<Scope>().router.profileDelegate;
    delegate.pages.add(ServiceDetailPage(url: serviceUrl));
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();
    final subscribe = scope.subscribes[serviceUrl];

    return ListTile(
      onTap: () => toDetail(context),
      title: Row(
        children: [
          Text(serviceUrl).expanded(),
          OnlineHint(subscribes: [
            if (subscribe != null) subscribe,
          ]),
        ],
      ),
    );
  }
}
