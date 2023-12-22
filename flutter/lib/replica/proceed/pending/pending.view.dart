import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/replica/proceed/pending/connect_pending/connect_pending.view.dart';
import 'package:ENC/replica/proceed/pending/host_pending/host_pending.view.dart';
import 'package:ENC/replica/replica.controller.dart';
import 'package:ENC/replica/replica.view.dart';

class ReplicaProceedPending extends StatelessWidget {
  const ReplicaProceedPending({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ReplicaController>();
    switch (controller.connDirection) {
      case ReplicaConnDirection.host:
        return const ReplicaProceedHostPending();
      case ReplicaConnDirection.connect:
        return const ReplicaProceedConnectPending();
    }
  }
}
