import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/main.controller.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class AlterUsernamePage extends StatefulWidget {
  const AlterUsernamePage({super.key});

  @override
  State<StatefulWidget> createState() => _AlterUsernamePageState();
}

class _AlterUsernamePageState extends State<AlterUsernamePage> {
  late final scope = context.read<Scope>();
  late final textController = TextEditingController.fromValue(
    TextEditingValue(text: scope.snapshot.username),
  );

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit() async {
    final delegate = context.read<MainController>().rootDelegate;
    final newName = textController.text;
    final maxClock = scope.db.operations.clock.max();
    final selectCurrentClock = scope.db.operations.selectOnly()
      ..addColumns([maxClock]);
    final record = await selectCurrentClock.getSingleOrNull();
    final currentClock = record?.read(maxClock) ?? 0;
    final operation = PortableOperation()
      ..clientId = scope.deviceId
      ..clock = currentClock + 1
      ..payload = jsonEncode({
        'type': 'account/username',
        'payload': {
          'username': newName,
        },
      });
    await scope.operator.apply(operation);
    delegate.pages.removeLast();
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('修改用户名称'),
      ),
      body: Center(
        child: SizedBox(
          width: 360,
          child: TextField(
            controller: textController,
            decoration: const InputDecoration(
              label: Text('新的用户名'),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handleSubmit,
        child: const Icon(Icons.save),
      ),
    );
  }
}
