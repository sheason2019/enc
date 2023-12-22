import 'package:flutter/material.dart';
import 'package:ENC/scope/scope.model.dart';

class ServiceSelectorController extends ChangeNotifier {
  final Scope scope;
  ServiceSelectorController(this.scope) {
    serviceUrl = services.firstOrNull;
  }

  String? get serviceUrl => _serviceUrl;
  set serviceUrl(String? value) {
    _serviceUrl = value;
    notifyListeners();
  }

  String? _serviceUrl;

  List<String> get services => scope.snapshot.serviceMap.keys.toList();
}
