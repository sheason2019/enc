import 'dart:io' as io;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:sheason_chat/cyprto/crypto_map_helper.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'session.dart';

class Chain {
  final AccountSecret secret;
  String deviceId = '';
  final sessionMap = <String, ChainSession>{}.obs;

  Chain({required this.secret});

  init() async {
    // 初始化 DeviceID
    await initDeviceId();
  }

  initDeviceId() async {
    final plugin = DeviceInfoPlugin();
    if (io.Platform.isWindows) {
      final diviceInfo = await plugin.windowsInfo;
      deviceId = diviceInfo.deviceId;
    }
    if (io.Platform.isAndroid) {
      final deviceInfo = await plugin.androidInfo;
      deviceId = deviceInfo.device;
    }
  }

  attachEvent(Socket socket) {
    // 新用户 Subscribe 时，发出 Offer
    socket.on('subscribe', (data) async {
      final socketId = data['socketId'];

      if (sessionMap.containsKey(socketId)) {
        sessionMap.remove(socketId)?.dispose();
      }

      final session = await ChainSession.create(
        secret,
        socket,
        socketId,
        deviceId,
      );
      final pc = session.pc;

      final offer = await pc.createOffer();
      await pc.setLocalDescription(offer);

      sessionMap[socketId] = session;

      socket.emit(
        'offer',
        {
          ...await CryptoMapHelper.encryptMap(secret, offer.toMap()),
          'socketId': socketId,
        },
      );
    });

    socket.on('offer', (data) async {
      final socketId = data['socketId'];
      if (sessionMap.containsKey(socketId)) {
        sessionMap.remove(socketId)?.dispose();
      }

      final session = await ChainSession.create(
        secret,
        socket,
        socketId,
        deviceId,
      );
      final pc = session.pc;

      sessionMap[socketId] = session;

      final offerMap = await CryptoMapHelper.decryptMap(secret, data);
      await pc.setRemoteDescription(
        RTCSessionDescription(offerMap['sdp'], offerMap['type']),
      );

      final answer = await pc.createAnswer();
      await pc.setLocalDescription(answer);
      socket.emit(
        'answer',
        {
          ...await CryptoMapHelper.encryptMap(secret, answer.toMap()),
          'socketId': socketId,
        },
      );
      session.candidateSendCompleter.complete();
    });

    socket.on('answer', (data) async {
      final socketId = data['socketId'];
      final session = sessionMap[socketId];
      if (session == null) return;

      final answerMap = await CryptoMapHelper.decryptMap(secret, data);
      await session.pc.setRemoteDescription(
        RTCSessionDescription(answerMap['sdp'], answerMap['type']),
      );
      session.candidateSendCompleter.complete();
    });

    socket.on('ice-candidate', (data) async {
      final socketId = data['socketId'];
      final session = sessionMap[socketId];
      print('candidate $socketId $session');
      if (session == null) return;

      final candidateMap = await CryptoMapHelper.decryptMap(secret, data);
      await session.pc.addCandidate(
        RTCIceCandidate(
          candidateMap['candidate'],
          candidateMap['sdpMid'],
          candidateMap['sdpMLineIndex'],
        ),
      );
    });
  }

  dispose() {
    for (final session in sessionMap.values) {
      session.dispose();
    }
  }
}
