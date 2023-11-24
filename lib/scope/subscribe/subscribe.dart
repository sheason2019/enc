import 'package:sheason_chat/scope/chain/chain.dart';
import 'package:socket_io_client/socket_io_client.dart';

class Subscribe {
  final Chain chain;
  final String url;
  Subscribe({required this.chain, required this.url});

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
        'signPubkey': chain.secret.signPubKey,
        'deviceId': chain.deviceId,
      });
    });
    chain.attachEvent(socket);

    socket.connect();
  }

  handleSendMessage() async {
    socket.emit('message', 'Hello world');
  }

  dispose() {
    socket.dispose();
  }
}
