import 'package:flutter/material.dart';
import 'package:sheason_chat/accounts/accounts.view.dart';
import 'package:sheason_chat/home/home.view.dart';
import 'package:sheason_chat/router/base_delegate.dart';
import 'package:sheason_chat/scope/scope.collection.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:sheason_chat/scope/scope.view.dart';

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
