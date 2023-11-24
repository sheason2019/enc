import 'dart:async';
import 'dart:io';

import 'package:isar/isar.dart';
import 'package:path/path.dart' as path;
import 'package:get/get.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/operation.dart';
import 'package:sheason_chat/scope/chain/chain.dart';
import 'package:sheason_chat/scope/subscribe/subscribe.dart';

class Scope {
  final String accountPath;
  Scope({required this.accountPath});
  final subs = <StreamSubscription>[];

  final secret = AccountSecret().obs;
  final snapshot = AccountSnapshot().obs;
  final subscribes = <String, Subscribe>{}.obs;

  late Chain chain;
  late Isar isar;

  Future handleUpdateSnapshot() async {
    final snapshotFile = File(path.join(accountPath, '.snapshot'));
    if (!await snapshotFile.exists()) return;

    final snapshot = AccountSnapshot.fromBuffer(
      await snapshotFile.readAsBytes(),
    );
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

  init() async {
    // 获取 secret 和 snapshot
    await handleUpdateSnapshot();
    await handleUpdateSecret();
    final isar = Isar.open(
      schemas: [
        OperationSchema,
      ],
      directory: accountPath,
      inspector: false,
      name: path.basename(accountPath),
    );
    this.isar = isar;
    // 构建用户私有链的控制器
    chain = Chain(secret: secret.value);
    await chain.init();

    // 构建服务器长连接，并注入私有链控制器
    const url = 'http://192.168.31.174';
    final subscribe = Subscribe(chain: chain, url: url);
    await subscribe.init();

    subscribes[url] = subscribe;
  }

  dispose() {
    for (final sub in subs) {
      sub.cancel();
    }
    isar.close();
  }
}
