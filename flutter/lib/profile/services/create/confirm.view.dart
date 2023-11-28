import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/scope.model.dart';

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
    final operation = await scope.operator.createOperation(jsonEncode({
      'type': 'account/service/create',
      'payload': {
        'url': url,
        'service': base64Encode(service.writeToBuffer()),
      },
    }));
    await scope.operator.apply([operation]);
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
