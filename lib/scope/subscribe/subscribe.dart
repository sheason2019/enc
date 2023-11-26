import 'dart:convert';
import 'dart:developer';

import 'package:drift/drift.dart';
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
      socket.emitWithAck('subscribe', {
        'deviceId': deviceId,
        'snapshot': base64Encode(scope.snapshot.writeToBuffer()),
      }, ack: (data) async {
        // 寻找每一个 Client ID 下最大的 Clock
        final maxClock = scope.db.operations.clock.max();
        final select = scope.db.operations.selectOnly();
        select.addColumns([
          scope.db.operations.clientId,
          maxClock,
        ]);
        select.groupBy([scope.db.operations.clientId]);
        final result = await select.get();

        log('replica set::$result');
      });
    });

    socket.connect();
  }

  handleSendMessage() async {
    socket.emit('message', 'Hello world');
  }

  dispose() {
    socket.dispose();
  }
}
