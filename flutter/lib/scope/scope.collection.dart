import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sheason_chat/cyprto/crypto_utils.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/notifier/notifier.controller.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ScopeCollection extends ChangeNotifier {
  final subs = <StreamSubscription>[];
  final scopeMap = <String, Scope>{};
  final notifier = Notifier.create();

  Future<String> get accountsPath async {
    final dir = await getApplicationDocumentsDirectory();
    return path.join(dir.path, 'sheason_chat', 'accounts');
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
        accountPath: append,
        notifier: notifier,
      );
      scopeMap[append] = scope;
      await scope.init();
    }
    notifyListeners();
  }

  Future<void> createScope() async {
    final keypair = await CryptoUtils.generate();
    final secret = AccountSecret()
      ..ecdhPubKey = keypair.ecdhPubKey
      ..ecdhPrivKey = keypair.ecdhPrivKey
      ..signPubKey = keypair.signPubKey
      ..signPrivKey = keypair.signPrivKey;
    await createScopeBySecret(secret);
  }

  Future<Scope> createScopeBySecret(AccountSecret secret) async {
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

    final newAccountPath = path.join(
      await accountsPath,
      secret.signPubKey,
    );
    return scopeMap[newAccountPath]!;
  }

  Future<Scope?> findScope(String signPubkey) async {
    final p = path.join(await accountsPath, signPubkey);
    return scopeMap[p];
  }

  Future<void> deleteScope(Scope scope) async {
    final dir = Directory(
      path.join(await accountsPath, scope.secret.signPubKey),
    );
    await dir.delete(recursive: true);
    await updateScopes();
  }

  Future<Scope?> findDefaultScope() async {
    final file = File(path.join(await accountsPath, '.active-account'));
    if (await file.exists()) {
      return scopeMap[await file.readAsString()];
    } else {
      return null;
    }
  }

  Future<void> setDefaultScope(Scope? scope) async {
    final file = File(path.join(await accountsPath, '.active-account'));
    if (scope != null) {
      await file.writeAsString(scope.paths.root);
    } else {
      await file.writeAsString('');
    }
  }

  @override
  void dispose() {
    for (final sub in subs) {
      sub.cancel();
    }
    for (final scope in scopeMap.values) {
      scope.dispose();
    }
    super.dispose();
  }
}
