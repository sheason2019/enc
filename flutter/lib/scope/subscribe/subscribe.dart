import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:sheason_chat/cyprto/crypto_utils.dart';
import 'package:sheason_chat/dio.dart';
import 'package:sheason_chat/extensions/sign_wrapper/sign_wrapper.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/operation_cipher/operation_cipher.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:sheason_chat/utils/sign_helper.dart';
import 'package:socket_io_client/socket_io_client.dart';

class Subscribe extends ChangeNotifier {
  final Scope scope;
  final String deviceId;
  final String url;

  var connected = false;
  var _syncMessage = false;

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

    socket.onDisconnect((data) {
      debugPrint('disconnect data $data');
      connected = false;
      notifyListeners();
    });

    socket.onConnect((data) async {
      await handleUploadSnapshot();
      socket.emitWithAck(
        'subscribe',
        {
          'deviceId': deviceId,
          'snapshot': base64Encode(scope.snapshot.writeToBuffer()),
        },
        ack: (_) {
          connected = true;
          notifyListeners();
        },
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
      var blocks = (cipherOperations.length / 20).ceil();
      if (blocks == 0) return;

      for (var i = 0; i < blocks; i++) {
        socket.emit('push-operation', {
          'operations': cipherOperations.sublist(
            i * 20,
            min((i + 1) * 20, cipherOperations.length),
          ),
        });
      }
    });
    socket.on('push-operation', (data) async {
      final List operations = data['operations'];
      if (operations.isNotEmpty) {
        final portableOperations = await OperationCipher.decrypt(
          scope,
          operations,
        );
        await scope.operator.apply(portableOperations, isReplay: true);
      }

      if (!_syncMessage) {
        _syncMessage = true;
        syncMessage();
      }
    });
    socket.on('push-message', (data) async {
      final List messages = jsonDecode(data['messages']);
      final wrappers = messages
          .map((e) => base64Decode(e))
          .map((e) => SignWrapper.fromBuffer(e));
      var i = 0;
      final operations = <PortableOperation>[];
      for (final wrapper in wrappers) {
        final valid = await wrapper.verify();
        if (!valid) continue;

        switch (wrapper.contentType) {
          case ContentType.CONTENT_MESSAGE:
            final operation = await scope.operator.factory.message(
              wrapper,
              offset: i++,
            );
            operations.add(operation);
            break;
          case ContentType.CONTENT_CONVERSATION:
            final operation = await scope.operator.factory.conversation(
              PortableConversation.fromBuffer(
                await SignHelper.unwrap(scope, wrapper),
              ),
            );
            operations.add(operation);
            break;
          default:
            debugPrint('[WARN] Unproceed wrapper');
        }
      }
      if (operations.isNotEmpty) {
        await scope.operator.apply(operations, isReplay: false);
      }
    });

    socket.on('sync-operation', (data) => syncOperation());
    socket.on('pull-snapshot', (data) async {
      await handleUploadSnapshot();
      socket.emitWithAck('subscribe', {
        'deviceId': deviceId,
        'snapshot': base64Encode(scope.snapshot.writeToBuffer()),
      });
    });

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

  syncMessage() async {
    final select = scope.db.messageSignatures.select();
    final records = await select.get();
    socket.emit('sync-message', {
      'signatures': records.map((e) => base64Encode(e.signature)).toList(),
    });
  }

  handleUploadSnapshot() async {
    final buffer = scope.snapshot.writeToBuffer();
    final sign = await CryptoUtils.createSignature(scope, buffer);

    final wrapper = SignWrapper()
      ..buffer = buffer
      ..signer = scope.snapshot.index
      ..sign = sign.bytes;

    await dio.put(
      '$url/account/${scope.snapshot.index.signPubKey}',
      data: FormData.fromMap({
        'snapshot': base64Encode(wrapper.writeToBuffer()),
      }),
    );
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }
}
