import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/replica/replica.controller.dart';

class ReplicaProceedHostPendingText extends StatelessWidget {
  const ReplicaProceedHostPendingText({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ReplicaController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: const Text('URL'),
          subtitle: Text(controller.url),
        ),
        ListTile(
          title: const Text('连接码'),
          subtitle: Text(controller.namespace ?? ''),
        ),
      ],
    );
  }
}
