import 'dart:convert';
import 'dart:io';

import 'package:ENC/models/conversation_anchor.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:ENC/scope/scope.model.dart';
import 'package:path_provider/path_provider.dart';

import './persist_adapter.dart';

class FsAdapter extends ChangeNotifier
    with AdapterMixin
    implements PersistAdapter {
  @override
  Future<void> init() async {
    await updateScopes();
  }

  Future<String> get accountsPath async {
    final dir = await getApplicationDocumentsDirectory();
    return path.join(dir.path, 'ENC', 'accounts');
  }

  @override
  Future<Scope> createScope(AccountSecret secret) async {
    final accountDir = Directory(
      path.join(await accountsPath, secret.signPubKey),
    );
    if (await accountDir.exists()) {
      throw Exception('Account already exist');
    }
    await accountDir.create(recursive: true);

    final secretFile = File(path.join(accountDir.path, '.secret'));
    await secretFile.writeAsBytes(secret.writeToBuffer());

    final accountIndex = AccountIndex()
      ..signPubKey = secret.signPubKey
      ..ecdhPubKey = secret.ecdhPubKey;
    final accountSnapshot = AccountSnapshot()
      ..username = secret.signPubKey
      ..index = accountIndex;
    final snapshotFile = File(path.join(accountDir.path, '.snapshot'));
    await snapshotFile.writeAsBytes(accountSnapshot.writeToBuffer());
    await updateScopes();
    return scopeMap[accountDir.path]!;
  }

  @override
  Future<void> deleteScope(Scope scope) async {
    await scope.dispose();
    final dir = Directory(
      path.join(await accountsPath, scope.secret.signPubKey),
    );
    await dir.delete(recursive: true);
    updateScopes();
  }

  @override
  Future<Scope?> getDefaultScope() async {
    final file = File(path.join(await accountsPath, '.active-account'));
    if (await file.exists()) {
      return scopeMap[await file.readAsString()];
    } else {
      return null;
    }
  }

  @override
  Future<void> setDefaultScope(Scope? scope) async {
    final file = File(path.join(await accountsPath, '.active-account'));
    if (scope != null) {
      await file.writeAsString(scope.paths.root);
    } else {
      await file.writeAsString('');
    }
  }

  updateScopes() async {
    final dir = Directory(await accountsPath);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    final entries = dir.listSync();
    final paths = entries
        .map((e) => e.path)
        .where((e) => !path.basename(e).startsWith('.'))
        .toList();

    final deleteSet = scopeMap.keys.toSet();
    final appendSet = <String>{};
    for (final p in paths) {
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
  Future<void> dispose() async {
    super.dispose();
    for (final scope in scopeMap.values) {
      await scope.dispose();
    }
  }

  @override
  Future<AccountSecret> getAccountSecret(String accountKey) async {
    final secretFile = File(path.join(accountKey, '.secret'));

    return AccountSecret.fromBuffer(
      await secretFile.readAsBytes(),
    );
  }

  @override
  Future<AccountSnapshot> getAccountSnapshot(String accountKey) async {
    final snapshotFile = File(path.join(accountKey, '.snapshot'));

    return AccountSnapshot.fromBuffer(
      await snapshotFile.readAsBytes(),
    );
  }

  @override
  Future<void> setAccountSecret(
    String accountKey,
    AccountSecret secret,
  ) async {
    final secretFile = File(path.join(accountKey, '.secret'));
    await secretFile.writeAsBytes(secret.writeToBuffer());
  }

  @override
  Future<void> setAccountSnapshot(
    String accountKey,
    AccountSnapshot snapshot,
  ) async {
    final snapshotFile = File(path.join(accountKey, '.snapshot'));
    await snapshotFile.writeAsBytes(snapshot.writeToBuffer());
  }

  @override
  Future<ConversationAnchor> getConversationAnchor(String accountKey) async {
    final anchorFile = File(path.join(
      accountKey,
      '.conversation-anchor',
    ));

    return ConversationAnchor.fromJson(
      jsonDecode(await anchorFile.readAsString()),
    );
  }

  @override
  Future<void> setConversationAnchor(
    String accountKey,
    ConversationAnchor anchor,
  ) async {
    final anchorFile = File(path.join(
      accountKey,
      '.conversation-anchor',
    ));

    await anchorFile.writeAsString(
      jsonEncode(anchor.toJson()),
    );
  }
}
