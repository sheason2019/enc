import 'package:flutter/material.dart';
import 'package:ENC/accounts/accounts.view.dart';
import 'package:ENC/home/home.view.dart';
import 'package:ENC/router/base_delegate.dart';
import 'package:ENC/scope/scope.collection.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:ENC/scope/scope.view.dart';

class MainController extends ChangeNotifier {
  Scope? get scope => _scope;
  Scope? _scope;

  final rootDelegate = BaseDelegate(
    initialPage: const HomePage(),
  );

  handleEnterScope(ScopeCollection collection, Scope? scope) async {
    rootDelegate.pages.clear();
    if (scope == null) {
      rootDelegate.pages.add(const AccountsPage());
    } else {
      rootDelegate.pages.add(ScopePage(scope: scope));
    }
    await collection.setDefaultScope(scope);
    _scope = scope;
    notifyListeners();
    rootDelegate.notify();
  }

  @override
  void dispose() {
    rootDelegate.dispose();
    super.dispose();
  }
}
