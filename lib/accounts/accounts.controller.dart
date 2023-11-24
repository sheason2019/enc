import 'dart:async';
import 'dart:io';

import 'package:fixnum/fixnum.dart';
import 'package:path/path.dart' as path;
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sheason_chat/cyprto/crypto_utils.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class AccountsController extends GetxController {
  final subs = <StreamSubscription>[];
  final scopeMap = <String, Scope>{}.obs;

  Future<String> get accountsPath async {
    final dir = await getApplicationDocumentsDirectory();
    return path.join(dir.path, 'sheason_chat', 'accounts');
  }

  handleUpdateAccounts() async {
    final entries = Directory(await accountsPath).listSync();
    final paths = entries.map((e) => e.path).toList();

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
      scopeMap[append] = Scope(accountPath: append)..init();
    }
  }

  Future<void> handleCreateAccount() async {
    final keypair = await CryptoUtils.generate();
    final secret = AccountSecret()
      ..ecdhPubKey = keypair.ecdhPubKey
      ..ecdhPrivKey = keypair.ecdhPrivKey
      ..signPubKey = keypair.signPubKey
      ..signPrivKey = keypair.signPrivKey;
    await createAccountBySecret(secret);
  }

  Future<Scope> createAccountBySecret(AccountSecret secret) async {
    final accountDir = Directory(
      path.join(await accountsPath, secret.signPubKey),
    );
    if (await accountDir.exists()) {
      await accountDir.delete(recursive: true);
    }
    await accountDir.create(recursive: true);

    final secretFile = File(path.join(accountDir.path, '.secret'));
    await secretFile.writeAsBytes(secret.writeToBuffer());

    final accountIndex = AccountIndex()
      ..signPubKey = secret.signPubKey
      ..ecdhPubKey = secret.ecdhPubKey;
    final accountSnapshot = AccountSnapshot()
      ..username = secret.signPubKey
      ..index = accountIndex
      ..createdAt = Int64(DateTime.now().millisecondsSinceEpoch);
    final snapshotFile = File(path.join(accountDir.path, '.snapshot'));
    await snapshotFile.writeAsBytes(accountSnapshot.writeToBuffer());
    await handleUpdateAccounts();

    final newAccountPath = path.join(
      await accountsPath,
      secret.signPubKey,
    );
    return scopeMap[newAccountPath]!;
  }

  Future<void> handleDeleteAccount(Scope scope) async {
    final dir = Directory(
      path.join(await accountsPath, scope.secret.value.signPubKey),
    );
    await dir.delete(recursive: true);
    await handleUpdateAccounts();
  }

  @override
  void onInit() {
    handleUpdateAccounts();
    super.onInit();
  }

  @override
  void onClose() {
    for (final sub in subs) {
      sub.cancel();
    }
    for (final scope in scopeMap.values) {
      scope.dispose();
    }
    super.onClose();
  }
}
