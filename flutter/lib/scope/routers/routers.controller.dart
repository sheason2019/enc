import 'package:ENC/router/base_delegate.dart';
import 'package:flutter/material.dart';

class ScopeRouter extends ChangeNotifier {
  var _tabIndex = 0;
  int get tabIndex => _tabIndex;
  set tabIndex(int value) {
    _tabIndex = value;

    switch (value) {
      case 0:
        contactDelegate.pages.clear();
        contactDelegate.notify();
        profileDelegate.pages.clear();
        profileDelegate.notify();
        break;
      case 1:
        chatDelegate.pages.clear();
        chatDelegate.notify();
        profileDelegate.pages.clear();
        profileDelegate.notify();
        break;
      case 2:
        chatDelegate.pages.clear();
        chatDelegate.notify();
        contactDelegate.pages.clear();
        contactDelegate.notify();
    }

    notifyListeners();
  }

  final chatDelegate = BaseDelegate();
  final contactDelegate = BaseDelegate();
  final profileDelegate = BaseDelegate();

  @override
  void dispose() {
    chatDelegate.dispose();
    contactDelegate.dispose();
    profileDelegate.dispose();
    super.dispose();
  }
}
