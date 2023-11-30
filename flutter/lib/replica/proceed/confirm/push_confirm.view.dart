import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/replica/replica.controller.dart';
import 'package:styled_widget/styled_widget.dart';

class ReplicaProceedConfirmPush extends StatefulWidget {
  const ReplicaProceedConfirmPush({super.key});
  @override
  State<StatefulWidget> createState() => _ReplicaProceedConfirmPushState();
}

class _ReplicaProceedConfirmPushState extends State<ReplicaProceedConfirmPush> {
  final codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ReplicaController>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: codeController,
          decoration: const InputDecoration(label: Text('传输验证码')),
        ).width(360).center(),
        ListenableBuilder(
          listenable: codeController,
          builder: (context, _) {
            final allow = codeController.text.toUpperCase() ==
                controller.target!.index.ecdhPubKey
                    .substring(0, 8)
                    .toUpperCase();

            return FilledButton(
              onPressed: allow ? controller.handleSendSecret : null,
              child: const Text('传输账号'),
            );
          },
        ).padding(top: 12),
      ],
    );
  }
}
