import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/account_paths/account_paths.dart';
import 'package:sheason_chat/scope/operator/operator.dart';
import 'package:sheason_chat/scope/subscribe/subscribe.dart';
import 'package:sheason_chat/scope/uploader/uploader.dart';

import '../models/conversation_anchor.dart';

class Scope extends ChangeNotifier {
  final AccountPaths paths;
  Scope({required String accountPath})
      : paths = AccountPaths(root: accountPath);
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

  Future handleUpdateSnapshot() async {
    final snapshotFile = File(paths.snapshot);
    if (!await snapshotFile.exists()) return;

    final snapshot = AccountSnapshot.fromBuffer(
      await snapshotFile.readAsBytes(),
    );
    this.snapshot = snapshot;
    await handleUpdateSubscribe();

    notifyListeners();
  }

  Future<void> handleSetSnapshot(AccountSnapshot snapshot) async {
    final snapshotFile = File(paths.snapshot);
    await snapshotFile.writeAsBytes(snapshot.writeToBuffer());
    this.snapshot = snapshot;
    notifyListeners();
  }

  Future<void> handleUpdateConversationAnchor() async {
    final anchorFile = File(paths.conversationAnchor);
    if (!await anchorFile.exists()) return;

    final anchor = ConversationAnchor.fromJson(
      jsonDecode(await anchorFile.readAsString()),
    );
    this.anchor = anchor;
    notifyListeners();
  }

  Future<void> handleSetConversationAnchor(
    ConversationAnchor anchor,
  ) async {
    final anchorFile = File(paths.conversationAnchor);
    await anchorFile.writeAsString(jsonEncode(anchor.toJson()));
    this.anchor = anchor;
    notifyListeners();
  }

  Future handleUpdateSecret() async {
    final secretFile = File(paths.secret);
    if (!await secretFile.exists()) return;

    final secret = AccountSecret.fromBuffer(
      await secretFile.readAsBytes(),
    );
    this.secret = secret;
    notifyListeners();
  }

  Future<void> handleInitIsar() async {
    db = AppDatabase(paths.root);
  }

  Future<void> handleInitDeviceId() async {
    final plugin = DeviceInfoPlugin();
    if (Platform.isWindows) {
      final diviceInfo = await plugin.windowsInfo;
      deviceId = diviceInfo.deviceId;
    }
    if (Platform.isAndroid) {
      final deviceInfo = await plugin.androidInfo;
      deviceId = deviceInfo.fingerprint;
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
  }

  init() async {
    // 获取 secret 和 snapshot
    await handleInitIsar();
    await handleInitDeviceId();
    await handleUpdateSecret();
    await handleUpdateSnapshot();
    await handleUpdateConversationAnchor();

    inited = true;
    notifyListeners();
  }

  @override
  void dispose() {
    for (final sub in subs) {
      sub.cancel();
    }
    for (final subscribe in subscribes.values) {
      subscribe.dispose();
    }
    db.close();
    super.dispose();
  }
}
