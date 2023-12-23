import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/accounts/account_avatar.view.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/replica/replica.controller.dart';
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
          leading: AccountAvatar(snapshot: target),
          title: Text(
            target.username,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            target.index.signPubKey,
            overflow: TextOverflow.ellipsis,
          ),
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
