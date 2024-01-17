import 'package:ENC/models/conversation_anchor.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/scope/notifier/notifier.controller.dart';
import 'package:ENC/scope/persist_adapter/fs_adapter.dart';
import 'package:ENC/scope/persist_adapter/web_adapter.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:flutter/foundation.dart';

abstract class PersistAdapter extends ChangeNotifier with AdapterMixin {
  Future<void> init();
  Future<void> deleteScope(Scope scope);
  Future<Scope> createScope(AccountSecret secret);
  Future<Scope?> getDefaultScope();
  Future<void> setDefaultScope(Scope? scope);

  Future<AccountSecret> getAccountSecret(String accountKey);
  Future<void> setAccountSecret(String accountKey, AccountSecret secret);
  Future<AccountSnapshot> getAccountSnapshot(String accountKey);
  Future<void> setAccountSnapshot(String accountKey, AccountSnapshot snapshot);
  Future<ConversationAnchor> getConversationAnchor(String accountKey);
  Future<void> setConversationAnchor(
    String accountKey,
    ConversationAnchor anchor,
  );

  factory PersistAdapter.create() {
    if (kIsWeb) {
      return WebAdapter();
    } else {
      return FsAdapter();
    }
  }
}

mixin AdapterMixin {
  final scopeMap = <String, Scope>{};
  final notifier = Notifier.create();
}
