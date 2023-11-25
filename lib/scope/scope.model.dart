import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart' as path;
import 'package:get/get.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/operation.dart';
import 'package:sheason_chat/scope/operator/operator.model.dart';
import 'package:sheason_chat/scope/subscribe/subscribe.dart';

class Scope {
  final String accountPath;
  Scope({required this.accountPath});
  final subs = <StreamSubscription>[];

  final secret = AccountSecret().obs;
  final snapshot = AccountSnapshot().obs;
  final subscribes = <String, Subscribe>{}.obs;

  late final operator = Operator(scope: this);

  late String deviceId;
  late Isar isar;

  Future handleUpdateSnapshot() async {
    final snapshotFile = File(path.join(accountPath, '.snapshot'));
    if (!await snapshotFile.exists()) return;

    final snapshot = AccountSnapshot.fromBuffer(
      await snapshotFile.readAsBytes(),
    );
    this.snapshot.value = snapshot;
  }

  Future<void> handleSetSnapshot(AccountSnapshot snapshot) async {
    final snapshotFile = File(path.join(accountPath, '.snapshot'));
    await snapshotFile.writeAsBytes(snapshot.writeToBuffer());
    this.snapshot.value = snapshot;
  }

  Future handleUpdateSecret() async {
    final secretFile = File(path.join(accountPath, '.secret'));
    if (!await secretFile.exists()) return;

    final secret = AccountSecret.fromBuffer(
      await secretFile.readAsBytes(),
    );
    this.secret.value = secret;
  }

  Future<void> handleInitIsar() async {
    final isar = await Isar.open(
      [
        OperationSchema,
      ],
      directory: accountPath,
      inspector: false,
      name: path.basename(accountPath),
    );
    this.isar = isar;
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

  init() async {
    // 获取 secret 和 snapshot
    await handleUpdateSnapshot();
    await handleUpdateSecret();
    await handleInitIsar();
    await handleInitDeviceId();

    // 构建服务器长连接，并注入私有链控制器
    const url = 'http://192.168.31.174';
    final subscribe = Subscribe(
      index: snapshot.value.index,
      secret: secret.value,
      url: url,
      deviceId: deviceId,
    );
    await subscribe.init();

    subscribes[url] = subscribe;
  }

  dispose() {
    for (final sub in subs) {
      sub.cancel();
    }
    for (final subscribe in subscribes.values) {
      subscribe.dispose();
    }
    isar.close();
  }
}
