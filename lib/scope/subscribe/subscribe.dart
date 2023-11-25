import 'dart:convert';

import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:socket_io_client/socket_io_client.dart';

class Subscribe {
  final AccountSecret secret;
  final AccountIndex index;
  final String deviceId;
  final String url;

  Subscribe({
    required this.secret,
    required this.index,
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
      socket.emit('subscribe', {
        'deviceId': deviceId,
        'index': base64Encode(index.writeToBuffer()),
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
