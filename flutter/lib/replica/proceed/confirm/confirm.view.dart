import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/replica/proceed/confirm/pull_confirm.view.dart';
import 'package:sheason_chat/replica/proceed/confirm/push_confirm.view.dart';
import 'package:sheason_chat/replica/replica.controller.dart';
import 'package:sheason_chat/replica/replica.view.dart';

class ReplicaProceedConfirm extends StatelessWidget {
  const ReplicaProceedConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ReplicaController>();

    if (controller.dataDirection == ReplicaDataDirection.push) {
      // Push 展示表单
      return const ReplicaProceedConfirmPush();
    } else {
      // Pull 展示用户信息和秘钥内容
      return const ReplicaProceedConfirmPull();
    }
  }
}
