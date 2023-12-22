import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/replica/replica.controller.dart';

class ReplicaProceedConnectPending extends StatelessWidget {
  const ReplicaProceedConnectPending({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ReplicaController>();

    // 错误展示
    if (controller.error != null) {
      return Center(
        child: Text(controller.error!.toString()),
      );
    }
    // 加载中

    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
