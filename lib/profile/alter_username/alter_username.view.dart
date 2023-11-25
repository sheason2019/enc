import 'package:flutter/material.dart';
import 'package:sheason_chat/profile/alter_username/alter_username.controller.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class AlterUsernamePage extends StatelessWidget {
  final Scope scope;
  const AlterUsernamePage({super.key, required this.scope});

  @override
  Widget build(BuildContext context) {
    final controller = AlterUsernameController(scope: scope);

    return Scaffold(
      appBar: AppBar(
        title: const Text('修改用户名称'),
      ),
      body: Center(
        child: SizedBox(
          width: 360,
          child: TextField(
            controller: controller.textController,
            decoration: const InputDecoration(
              label: Text('新的用户名'),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.handleSubmit,
        child: const Icon(Icons.save),
      ),
    );
  }
}
