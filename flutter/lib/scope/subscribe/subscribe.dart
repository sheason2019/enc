import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/operation_cipher/operation_cipher.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:socket_io_client/socket_io_client.dart';

class Subscribe {
  final Scope scope;
  final String deviceId;
  final String url;

  Subscribe({
    required this.scope,
    required this.url,
    required this.deviceId,
  });

  late Socket socket;
  init() async {
    socket = io(
      url,
      OptionBuilder()
          .setPath('/subscribe')
          .setTransports(['websocket'])
          .enableForceNewConnection()
          .disableAutoConnect()
          .build(),
    );

    socket.onConnect((data) {
      socket.emitWithAck(
        'subscribe',
        {
          'deviceId': deviceId,
          'snapshot': base64Encode(scope.snapshot.writeToBuffer()),
        },
        ack: (data) => syncOperation(),
      );
    });

    socket.on('pull-operation', (data) async {
      final Map pullMap = data;
      final select = scope.db.operations.select();
      select.where(
        (tbl) => Expression.or(
          pullMap.keys.map(
            (clientId) =>
                tbl.clientId.equals(clientId) &
                tbl.clock.isIn(
                  (pullMap[clientId] as List).map(
                    (e) => int.parse(e.toString()),
                  ),
                ),
          ),
        ),
      );
      final operations = await select.get();
      // 加密后上传到服务器
      final cipherOperations = await OperationCipher.encrypt(
        scope,
        operations,
      );
      final pushData = cipherOperations
          .map(
            (e) => {
              'clientId': e.clientId,
              'clock': e.clock,
              'data': base64Encode(e.writeToBuffer()),
            },
          )
          .toList();
      if (pushData.isNotEmpty) {
        socket.emit(
          'push-operation',
          {'operations': pushData},
        );
      }
    });
    socket.on('push-operation', (data) async {
      debugPrint('push operation $data');
      final operations = (data['operations'] as List)
          .map((e) => base64Decode(e['data']))
          .map((e) => PortableOperation.fromBuffer(e))
          .toList();
      await OperationCipher.decrypt(scope, operations);
      await scope.operator.apply(operations);
    });
    socket.on('sync-operation', (data) => syncOperation());

    socket.connect();
  }

  syncOperation() async {
    // 寻找每一个 Client ID 下最大的 Clock
    final clientId = scope.db.operations.clientId;
    final clock = scope.db.operations.clock;
    final select = scope.db.operations.selectOnly();
    select.addColumns([
      clientId,
      clock,
    ]);
    final replicaClockMap = <String, List<int>>{};
    final records = await select.get();
    for (final record in records) {
      final cid = record.read(clientId)!;
      final clo = record.read(clock)!;
      if (replicaClockMap[cid] == null) {
        replicaClockMap[cid] = [];
      }
      replicaClockMap[cid]!.add(clo);
    }

    socket.emit('sync-operation', replicaClockMap);
  }

  handleSendMessage() async {
    socket.emit('message', 'Hello world');
  }

  dispose() {
    socket.dispose();
  }
}
