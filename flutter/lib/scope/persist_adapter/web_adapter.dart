import 'dart:convert';

import 'package:ENC/models/conversation_anchor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/scope/persist_adapter/persist_adapter.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:flutter/foundation.dart';

class WebAdapter extends ChangeNotifier
    with AdapterMixin
    implements PersistAdapter {
  static const sDefaultScope = 'default_scope';

  late final SharedPreferences pref;

  @override
  Future<Scope> createScope(AccountSecret secret) async {
    await pref.setString(
      '${secret.signPubKey}/secret',
      base64Encode(secret.writeToBuffer()),
    );

    final accountIndex = AccountIndex()
      ..signPubKey = secret.signPubKey
      ..ecdhPubKey = secret.ecdhPubKey;
    final accountSnapshot = AccountSnapshot()
      ..username = secret.signPubKey
      ..index = accountIndex;
    await pref.setString(
      '${secret.signPubKey}/snapshot',
      base64Encode(accountSnapshot.writeToBuffer()),
    );
    await pref.setString(
      '${secret.signPubKey}/conversation-anchor',
      jsonEncode(ConversationAnchor(list: []).toJson()),
    );

    final scopes = pref.getStringList('scopes') ?? [];
    scopes.add(secret.signPubKey);
    await pref.setStringList('scopes', scopes);

    await updateScopes();
    return scopeMap[secret.signPubKey]!;
  }

  @override
  Future<void> deleteScope(Scope scope) async {
    await scope.dispose();

    final scopes = pref.getStringList('scopes') ?? [];
    scopes.remove(scope.secret.signPubKey);
    await pref.setStringList('scopes', scopes);

    await pref.remove('${scope.secret.signPubKey}/secret');
    await pref.remove('${scope.secret.signPubKey}/snapshot');
    await pref.remove('${scope.secret.signPubKey}/conversation-anchor');

    await updateScopes();
  }

  @override
  Future<Scope?> getDefaultScope() async {
    final defaultScope = pref.getString(sDefaultScope);
    return scopeMap[defaultScope];
  }

  @override
  Future<void> init() async {
    pref = await SharedPreferences.getInstance();
    await updateScopes();
  }

  @override
  Future<void> setDefaultScope(Scope? scope) async {
    if (scope != null) {
      await pref.setString(sDefaultScope, scope.secret.signPubKey);
    } else {
      await pref.remove(sDefaultScope);
    }
  }

  updateScopes() async {
    final scopes = pref.getStringList('scopes') ?? [];

    final deleteSet = scopeMap.keys.toSet();
    final appendSet = <String>{};
    for (final p in scopes) {
      if (!deleteSet.remove(p)) {
        appendSet.add(p);
      }
    }

    for (final delete in deleteSet) {
      scopeMap.remove(delete)?.dispose();
    }
    for (final append in appendSet) {
      final scope = Scope(
        accountKey: append,
        notifier: notifier,
        adapter: this,
      );
      scopeMap[append] = scope;
      await scope.init();
    }
    notifyListeners();
  }

  @override
  Future<AccountSecret> getAccountSecret(String accountKey) async {
    return AccountSecret.fromBuffer(
      base64Decode(pref.getString(
        '$accountKey/secret',
      )!),
    );
  }

  @override
  Future<AccountSnapshot> getAccountSnapshot(String accountKey) async {
    return AccountSnapshot.fromBuffer(
      base64Decode(pref.getString(
        '$accountKey/snapshot',
      )!),
    );
  }

  @override
  Future<void> setAccountSecret(
    String accountKey,
    AccountSecret secret,
  ) async {
    await pref.setString(
      '$accountKey/secret',
      base64Encode(secret.writeToBuffer()),
    );
  }

  @override
  Future<void> setAccountSnapshot(
    String accountKey,
    AccountSnapshot snapshot,
  ) async {
    await pref.setString(
      '$accountKey/snapshot',
      base64Encode(snapshot.writeToBuffer()),
    );
  }

  @override
  Future<ConversationAnchor> getConversationAnchor(String accountKey) async {
    return ConversationAnchor.fromJson(
      jsonDecode(pref.getString('$accountKey/conversation-anchor')!),
    );
  }

  @override
  Future<void> setConversationAnchor(
    String accountKey,
    ConversationAnchor anchor,
  ) async {
    await pref.setString(
      '$accountKey/conversation-anchor',
      jsonEncode(anchor.toJson()),
    );
  }
}
