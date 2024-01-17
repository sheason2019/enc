import 'package:ENC/scope/persist_adapter/persist_adapter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/main.controller.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:styled_widget/styled_widget.dart';

class ReplicaProceedSuccess extends StatelessWidget {
  const ReplicaProceedSuccess({super.key});

  handleClick(BuildContext context) {
    final scope = context.read<Scope?>();
    final mainController = context.read<MainController>();
    final adapter = context.read<PersistAdapter>();
    mainController.handleEnterScope(adapter, scope);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 96,
        ).padding(bottom: 6),
        Text(
          '传输账号成功',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        FilledButton(
          onPressed: () => handleClick(context),
          child: const Text('确认'),
        ).width(180).padding(top: 16, bottom: 48),
      ],
    ).center();
  }
}
