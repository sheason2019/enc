import 'dart:async';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sheason_chat/cyprto/crypto_map_helper.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChainSession {
  final AccountSecret secret;
  final RTCPeerConnection pc;
  final remoteChannel = <RTCDataChannel>[];
  final String socketId;
  final Socket socket;
  final localCandidate = <Map>[];
  final remoteCandidate = <Map>[];
  final candidateSendCompleter = Completer();
  final String deviceId;

  ChainSession({
    required this.pc,
    required this.socketId,
    required this.socket,
    required this.secret,
    required this.deviceId,
  });

  static Future<ChainSession> create(
    AccountSecret secret,
    Socket socket,
    String socketId,
    String deviceId,
  ) async {
    final pc = await createPeerConnection({
      'iceServers': [
        {'url': 'stun:stun.l.google.com:19302'},
      ],
      'sdpSemantics': 'unified-plan',
      'mandatory': {
        'OfferToReceiveAudio': true,
        'OfferToReceiveVideo': true,
      },
      'optional': [],
    });
    final session = ChainSession(
      pc: pc,
      secret: secret,
      socket: socket,
      socketId: socketId,
      deviceId: deviceId,
    );
    pc.onIceCandidate = (event) async {
      if (event.candidate != null) {
        await session.candidateSendCompleter.future;
        socket.emit(
          'ice-candidate',
          {
            ...await CryptoMapHelper.encryptMap(
              secret,
              event.toMap(),
            ),
            'socketId': socketId,
          },
        );
      }
    };
    final channel = await pc.createDataChannel(
      'data',
      RTCDataChannelInit()..maxRetransmits = 30,
    );
    channel.onDataChannelState = (state) {
      if (state == RTCDataChannelState.RTCDataChannelOpen) {
        channel.send(
            RTCDataChannelMessage('$deviceId Says: Data Channel is open!'));
      }
    };

    pc.onDataChannel = (channel) {
      channel.onMessage = (message) {
        print('data channel message ${message.text}');
      };
    };
    return session;
  }

  dispose() async {
    for (final c in remoteChannel) {
      c.close();
    }
    pc.dispose();
  }
}
