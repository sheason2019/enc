import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/replica/proceed/pending/pending.view.dart';
import 'package:ENC/replica/replica.controller.dart';
import 'package:ENC/replica/replica.view.dart';
import 'package:ENC/scope/scope.collection.dart';
import 'package:ENC/scope/scope.model.dart';

import 'confirm/confirm.view.dart';
import 'success/success.view.dart';

class ReplicaProceedPage extends StatelessWidget {
  final Scope? scope;
  final String? namespace;
  final ReplicaDataDirection dataDirection;
  final ReplicaConnDirection connDirection;
  final String url;

  const ReplicaProceedPage({
    super.key,
    required this.scope,
    required this.dataDirection,
    required this.connDirection,
    required this.url,
    required this.namespace,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (context) => ReplicaController(
        scope: scope,
        url: url,
        dataDirection: dataDirection,
        connDirection: connDirection,
        namespace: namespace,
        collection: context.read<ScopeCollection>(),
      )..start(),
      dispose: (context, controller) => controller.dispose(),
      builder: (context, _) => const _ReplicaProceedPagination(),
    );
  }
}

class _ReplicaProceedPagination extends StatefulWidget {
  const _ReplicaProceedPagination();
  @override
  State<StatefulWidget> createState() => _ReplicaProceedPaginationState();
}

class _ReplicaProceedPaginationState extends State<_ReplicaProceedPagination> {
  final pageController = PageController();

  void to(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );
  }

  void watchStatus() async {
    final controller = context.read<ReplicaController>();
    controller.statusNotifier.addListener(() {
      switch (controller.statusNotifier.value) {
        case ReplicaStatus.pending:
          return to(0);
        case ReplicaStatus.confirm:
          return to(1);
        case ReplicaStatus.success:
          return to(2);
      }
    });
  }

  @override
  void initState() {
    watchStatus();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('复制账号'),
      ),
      body: PageView(
        controller: pageController,
        children: const [
          ReplicaProceedPending(),
          ReplicaProceedConfirm(),
          ReplicaProceedSuccess(),
        ],
      ),
    );
  }
}
