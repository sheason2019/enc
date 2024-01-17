import 'package:ENC/scope/persist_adapter/persist_adapter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ENC/accounts/account_avatar.view.dart';
import 'package:ENC/accounts/online_hint/scope_online_hint.view.dart';
import 'package:ENC/main.controller.dart';
import 'package:ENC/scope/scope.model.dart';

class AccountListTile extends StatelessWidget {
  final Scope scope;
  const AccountListTile({super.key, required this.scope});

  handleEnterScope(BuildContext context) {
    final adapter = context.read<PersistAdapter>();
    final controller = context.read<MainController>();
    controller.handleEnterScope(adapter, scope);
  }

  handleDeleteScope(BuildContext context) {
    final adapter = context.read<PersistAdapter>();
    adapter.deleteScope(scope);
  }

  @override
  Widget build(BuildContext context) {
    final currentScope = context.watch<Scope?>();

    final current = currentScope == scope;

    return ColoredBox(
      color: current ? Colors.black.withOpacity(0.05) : Colors.transparent,
      child: ListTile(
        onTap: () => handleEnterScope(context),
        onLongPress: () => handleDeleteScope(context),
        leading: AccountAvatar(
          snapshot: scope.snapshot,
        ),
        title: Text(
          scope.snapshot.username,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          scope.snapshot.index.signPubKey,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: ScopeOnlineHint(
          scope: scope,
        ),
      ),
    );
  }
}
