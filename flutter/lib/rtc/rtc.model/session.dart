import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class RtcSession extends ChangeNotifier {
  final RTCPeerConnection peerConnection;

  final describeCompleter = Completer();

  // 三大数据源是否开启
  var dataChannelOpen = false;
  var audioOpen = false;
  var videoOpen = false;

  RtcSession({
    required this.peerConnection,
  }) {
    startHeartbeat();
  }

  Timer? _timer;

  int delay = -1;

  Future<void> startHeartbeat() async {
    final dataChannel = await peerConnection.createDataChannel(
      'heartbeat',
      RTCDataChannelInit(),
    );

    final sequence = <Map>[];
    final timer = Timer.periodic(Durations.extralong4, (timer) {
      final rand = Random();
      final key = rand.nextInt(100000000);
      final time = DateTime.now().millisecondsSinceEpoch;
      final pingMap = {
        'type': 'ping',
        'key': key,
        'time': time,
      };
      sequence.add(pingMap);
      if (sequence.length > 10) {
        sequence.removeAt(0);
      }

      dataChannel.send(RTCDataChannelMessage(jsonEncode(pingMap)));
    });
    _timer = timer;
    peerConnection.onDataChannel = (channel) {
      if (channel.label == 'heartbeat') {
        channel.onMessage = (data) {
          final Map json = jsonDecode(data.text);
          if (json['type'] == 'ping') {
            final pongMap = {
              'type': 'pong',
              'key': json['key'],
            };
            dataChannel.send(RTCDataChannelMessage(jsonEncode(pongMap)));
          }
          if (json['type'] == 'pong') {
            for (final item in sequence) {
              if (item['key'] == json['key']) {
                final now = DateTime.now().millisecondsSinceEpoch;
                final double time = (now - item['time']) / 2;
                delay = time.ceil();
                notifyListeners();
                sequence.remove(item);
                break;
              }
            }
          }
        };
      }
    };
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
