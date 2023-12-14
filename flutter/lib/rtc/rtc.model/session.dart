import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class RtcSession extends ChangeNotifier {
  final RTCPeerConnection peerConnection;
  RTCRtpSender? audioSender;
  RTCRtpSender? videoSender;

  final describeCompleter = Completer();

  late RTCDataChannel channel;

  bool get audioOpen => _audioOpen;
  set audioOpen(bool value) {
    _audioOpen = value;
    notifyListeners();
  }

  var _audioOpen = false;

  bool get videoOpen => _videoOpen;
  set videoOpen(bool value) {
    _videoOpen = value;
    notifyListeners();
  }

  var _videoOpen = false;

  final renderer = RTCVideoRenderer()..initialize();

  RtcSession({
    required this.peerConnection,
  }) {
    startHeartbeat();
  }

  Timer? _timer;

  int delay = -1;

  Future<void> startHeartbeat() async {
    channel = await peerConnection.createDataChannel(
      'channel',
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

      channel.send(RTCDataChannelMessage(jsonEncode(pingMap)));
    });
    _timer = timer;
    peerConnection.onDataChannel = (channel) {
      if (channel.label == 'channel') {
        channel.onMessage = (data) {
          final Map json = jsonDecode(data.text);
          if (json['type'] == 'ping') {
            final pongMap = {
              'type': 'pong',
              'key': json['key'],
            };
            channel.send(RTCDataChannelMessage(jsonEncode(pongMap)));
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
          if (json['type'] == 'media-status') {
            _receiveMediaStatus(json);
          }
        };
      }
    };
    peerConnection.onTrack = (event) {
      debugPrint('on track $event');
      renderer.srcObject?.dispose();
      debugPrint('on track streams ${event.streams}');
      renderer.srcObject = event.streams.first;
      notifyListeners();
    };
  }

  Future<void> sendMediaStatus({
    bool? videoOpen,
    bool? audioOpen,
  }) async {
    final json = <String, dynamic>{
      'type': 'media-status',
    };
    if (videoOpen != null) {
      json['video-open'] = videoOpen;
    }
    if (audioOpen != null) {
      json['audio-open'] = audioOpen;
    }

    await channel.send(RTCDataChannelMessage(jsonEncode(json)));
  }

  void _receiveMediaStatus(Map json) {
    final videoOpen = json['video-open'];
    final audioOpen = json['audio-open'];
    if (videoOpen != null) {
      this.videoOpen = videoOpen;
    }
    if (audioOpen != null) {
      this.audioOpen = audioOpen;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    renderer.dispose();
    renderer.srcObject?.dispose();
    super.dispose();
  }
}
