import 'package:flutter/material.dart';
import 'package:ENC/accounts/online_hint/online_hint.view.dart';
import 'package:ENC/scope/scope.model.dart';

class ScopeOnlineHint extends StatelessWidget {
  final Scope scope;
  const ScopeOnlineHint({super.key, required this.scope});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: scope,
      builder: (context, _) => OnlineHint(
        subscribes: scope.subscribes.values.toList(),
      ),
    );
  }
}
