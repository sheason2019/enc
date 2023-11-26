import 'dart:convert';
import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:sheason_chat/schema/operation.dart';
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
        final replicaClockMap = await scope.isar.operations
            .where(distinct: true)
            .sortByClock()
            .distinctByClientId()
            .findAll();
        log('replica set::$replicaClockMap');
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
