import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/main.controller.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/scope/scope.model.dart';

class ConfirmCreateServicePage extends StatelessWidget {
  final PortableService service;
  final String url;
  const ConfirmCreateServicePage({
    super.key,
    required this.service,
    required this.url,
  });

  handleCreateService(BuildContext context) async {
    final scope = context.read<Scope>();
    final delegate = context.read<MainController>().rootDelegate;
    final operation = await scope.operator.factory.service(url);
    await scope.operator.apply([operation], isReplay: false);

    await scope.handleUpdateSubscribe();

    delegate.pages.removeLast();
    delegate.pages.removeLast();
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('确认添加服务器'),
      ),
      body: Center(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          spacing: 16,
          children: [
            Text(url),
            FilledButton(
              onPressed: () => handleCreateService(context),
              child: const Text('添加服务器'),
            ),
          ],
        ),
      ),
    );
  }
}
