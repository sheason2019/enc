import 'package:ENC/accounts/account_avatar.view.dart';
import 'package:ENC/accounts/accounts.view.dart';
import 'package:ENC/main.controller.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountCollectionEntry extends StatelessWidget {
  const AccountCollectionEntry({super.key});

  toAccounts(BuildContext context) {
    final delegate = context.read<MainController>().rootDelegate;
    delegate.pages.add(const AccountsPage());
    delegate.notify();
  }

  @override
  Widget build(BuildContext context) {
    final scope = context.watch<Scope>();

    return GestureDetector(
      onTap: () => toAccounts(context),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AccountAvatar(
          snapshot: scope.snapshot,
        ),
      ),
    );
  }
}
