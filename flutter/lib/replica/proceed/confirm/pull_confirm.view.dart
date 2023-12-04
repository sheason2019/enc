import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/replica/replica.controller.dart';
import 'package:styled_widget/styled_widget.dart';

class ReplicaProceedConfirmPull extends StatelessWidget {
  const ReplicaProceedConfirmPull({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ReplicaController>();
    final target = controller.target ?? AccountSnapshot();

    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(),
          title: Text(target.username),
          subtitle: Text(target.index.signPubKey),
        ),
        Text(
          '传输验证码',
          style: Theme.of(context).textTheme.titleLarge,
        ).padding(top: 12),
        Text(
          controller.keypair.ecdhPubKey.substring(0, 8).toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(letterSpacing: 8),
        ).padding(top: 12),
        Text(
          '请在发送端输入上述传输验证码，以将账号复制到此设备',
          style: Theme.of(context).textTheme.labelMedium,
        ).padding(top: 12),
      ],
    );
  }
}