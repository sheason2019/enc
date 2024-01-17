import 'dart:async';
import 'dart:io';

import 'package:ENC/scope/persist_adapter/persist_adapter.dart';
import 'package:ENC/scope/routers/routers.controller.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/account_paths/account_paths.dart';
import 'package:ENC/scope/notifier/notifier.controller.dart';
import 'package:ENC/scope/operator/operator.dart';
import 'package:ENC/scope/subscribe/subscribe.dart';
import 'package:ENC/scope/uploader/uploader.dart';

import '../models/conversation_anchor.dart';

class Scope extends ChangeNotifier {
  final String accountKey;
  final AccountPaths paths;
  Scope({
    required this.accountKey,
    required this.notifier,
    required this.adapter,
  }) : paths = AccountPaths(root: accountKey);
  final subs = <StreamSubscription>[];

  var secret = AccountSecret();
  var snapshot = AccountSnapshot();
  var anchor = ConversationAnchor(list: []);
  var inited = false;
  final subscribes = <String, Subscribe>{};

  late final operator = Operator(scope: this);

  late String deviceId;
  late final AppDatabase db;
  late final uploader = Uploader(scope: this);

  final Notifier notifier;
  final PersistAdapter adapter;

  Future handleUpdateSnapshot() async {
    snapshot = await adapter.getAccountSnapshot(accountKey);
    await handleUpdateSubscribe();

    notifyListeners();
  }

  Future<void> handleSetSnapshot(AccountSnapshot snapshot) async {
    snapshot.version = this.snapshot.version + 1;
    await adapter.setAccountSnapshot(accountKey, snapshot);
    this.snapshot = snapshot;

    notifyListeners();
  }

  Future<void> handleUpdateConversationAnchor() async {
    anchor = await adapter.getConversationAnchor(accountKey);
    notifyListeners();
  }

  Future<void> handleSetConversationAnchor(
    ConversationAnchor anchor,
  ) async {
    await adapter.setConversationAnchor(accountKey, anchor);
    this.anchor = anchor;
    notifyListeners();
  }

  Future handleInitSecret() async {
    secret = await adapter.getAccountSecret(accountKey);
  }

  Future<void> handleInitDb() async {
    db = AppDatabase(paths.root);
  }

  Future<void> handleInitDeviceId() async {
    final plugin = DeviceInfoPlugin();
    if (kIsWeb) {
      final deviceInfo = await plugin.webBrowserInfo;
      deviceId = deviceInfo.userAgent ?? 'Unknown WebAgent';
      return;
    }
    if (Platform.isWindows) {
      final diviceInfo = await plugin.windowsInfo;
      deviceId = diviceInfo.deviceId;
      return;
    }
    if (Platform.isAndroid) {
      final deviceInfo = await plugin.androidInfo;
      deviceId = deviceInfo.fingerprint;
      return;
    }
  }

  Future<void> handleUpdateSubscribe() async {
    final removeSet = subscribes.keys.toSet();
    final appendSet = <String>{};

    for (final url in snapshot.serviceMap.keys) {
      if (!removeSet.remove(url)) {
        appendSet.add(url);
      }
    }

    for (final remove in removeSet) {
      subscribes.remove(remove)?.dispose();
    }
    for (final append in appendSet) {
      final subscribe = Subscribe(
        scope: this,
        url: append,
        deviceId: deviceId,
      );
      await subscribe.init();
      subscribes[append] = subscribe;
    }

    notifyListeners();
  }

  init() async {
    // 获取 secret 和 snapshot
    await handleInitDb();
    await handleInitDeviceId();
    await handleInitSecret();
    await handleUpdateSnapshot();
    await handleUpdateConversationAnchor();

    inited = true;
    notifyListeners();
  }

  final router = ScopeRouter();

  @override
  Future<void> dispose() async {
    for (final sub in subs) {
      await sub.cancel();
    }
    for (final subscribe in subscribes.values) {
      subscribe.dispose();
    }
    router.dispose();
    await db.close();
    super.dispose();
  }
}
