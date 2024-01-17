import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/scope/persist_adapter/persist_adapter.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:flutter/foundation.dart';

class WebAdapter extends ChangeNotifier
    with AdapterMixin
    implements PersistAdapter {
  @override
  Future<Scope> createScope(AccountSecret secret) {
    // TODO: implement createScope
    throw UnimplementedError();
  }

  @override
  deleteScope(Scope scope) {
    // TODO: implement deleteScope
    throw UnimplementedError();
  }

  @override
  Future<Scope?> getDefaultScope() {
    // TODO: implement getDefaultScope
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<void> setDefaultScope(Scope? scope) {
    // TODO: implement setDefaultScope
    throw UnimplementedError();
  }
}
