import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/scope/notifier/notifier.controller.dart';
import 'package:ENC/scope/persist_adapter/fs_adapter.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:flutter/material.dart';

abstract class PersistAdapter extends ChangeNotifier with AdapterMixin {
  Future<void> init();
  deleteScope(Scope scope);
  Future<Scope> createScope(AccountSecret secret);
  Future<Scope?> getDefaultScope();
  Future<void> setDefaultScope(Scope? scope);

  factory PersistAdapter.create() {
    return FsAdapter();
  }
}

mixin AdapterMixin {
  final scopeMap = <String, Scope>{};
  final notifier = Notifier.create();
}
