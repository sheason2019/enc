import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sheason_chat/models/rtc_model.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/rtc/rtc.model/member.dart';
import 'package:sheason_chat/rtc/rtc.model/session.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:sheason_chat/utils/sign_helper.dart';
import 'package:socket_io_client/socket_io_client.dart';

enum RtcControllerStatus {
  init,
  connectedSignaling,
  connectedRoom,
  exchanging,
  connected,
}

class RtcController extends ChangeNotifier {
  RtcControllerStatus status = RtcControllerStatus.init;

  final Scope scope;
  final RtcModel model;
  RtcController({
    required this.model,
    required this.scope,
  });

  late Socket socket;

  final clientMap = <String, RtcMember>{};

  Future<void> connect() async {
    final socket = io(
      model.serviceUrl,
      OptionBuilder()
          .setPath('/rtc.io')
          .setTransports(['websocket'])
          .enableForceNewConnection()
          .disableAutoConnect()
          .build(),
    );

    socket.onConnect((data) async {
      for (final client in clientMap.values) {
        client.dispose();
      }
      clientMap.clear();
      // 成功连接到信令服务器
      status = RtcControllerStatus.connectedSignaling;
      notifyListeners();

      // 为身份校验和接入通话创建 SignWrapper
      final wrapper = await SignHelper.wrap(
        scope,
        jsonEncode({
          'snapshot': base64Encode(scope.snapshot.writeToBuffer()),
          'uuid': model.uuid,
        }).codeUnits,
      );

      socket.emitWithAck(
        'join',
        {'wrapper': base64Encode(wrapper.writeToBuffer())},
        ack: (_) {
          final clientId = socket.id!;
          clientMap[clientId] = RtcMember(
            snapshot: scope.snapshot,
            clientId: clientId,
            session: null,
          );

          status = RtcControllerStatus.connectedRoom;
          notifyListeners();
        },
      );
    });

    socket.on('join', (data) async {
      final wrapper = SignWrapper.fromBuffer(base64Decode(data['wrapper']));
      final clientId = data['clientId'];

      final buffer = await SignHelper.unwrap(scope, wrapper);
      final snapshot = AccountSnapshot.fromBuffer(
        base64Decode(jsonDecode(String.fromCharCodes(buffer))['snapshot']),
      );

      final session = await _createSession(clientId);

      clientMap[clientId] = RtcMember(
        snapshot: snapshot,
        clientId: clientId,
        session: session,
      );
      final pc = session.peerConnection;

      final offer = await pc.createOffer();
      await pc.setLocalDescription(offer);

      final exchangeData = {
        'type': 'offer',
        'payload': offer.toMap(),
      };

      await _sendExchangeData(clientId, exchangeData);

      notifyListeners();
    });
    socket.on('members', (data) async {
      final members = data['members'];
      for (final member in members) {
        final String clientId = member['clientId'];
        final wrapper = SignWrapper.fromBuffer(
          base64Decode(member['wrapper']),
        );

        final buffer = await SignHelper.unwrap(scope, wrapper);
        final snapshot = AccountSnapshot.fromBuffer(
          base64Decode(jsonDecode(String.fromCharCodes(buffer))['snapshot']),
        );

        final session = await _createSession(clientId);

        clientMap[clientId] = RtcMember(
          snapshot: snapshot,
          clientId: clientId,
          session: session,
        );
      }

      notifyListeners();
    });

    socket.on('leave', (data) {
      final clientId = data['clientId'];

      final member = clientMap.remove(clientId);
      member?.dispose();

      notifyListeners();
    });

    socket.on('exchange', (data) async {
      final String clientId = data['clientId'];
      final wrapper = SignWrapper.fromBuffer(
        base64Decode(data['wrapper']),
      );
      final Map content = jsonDecode(String.fromCharCodes(
        await SignHelper.unwrap(scope, wrapper),
      ));
      final String type = content['type'];
      final Map payload = content['payload'];

      switch (type) {
        case 'offer':
          final session = clientMap[clientId]?.session;
          if (session == null) break;
          final offer = RTCSessionDescription(
            payload['sdp'],
            payload['type'],
          );
          final pc = session.peerConnection;
          await pc.setRemoteDescription(offer);
          final answer = await pc.createAnswer();
          await pc.setLocalDescription(answer);
          await _sendExchangeData(clientId, {
            'type': 'answer',
            'payload': answer.toMap(),
          });
          session.describeCompleter.complete();
          break;
        case 'answer':
          final session = clientMap[clientId]?.session;
          if (session == null) break;
          final answer = RTCSessionDescription(
            payload['sdp'],
            payload['type'],
          );
          final pc = session.peerConnection;
          await pc.setRemoteDescription(answer);
          session.describeCompleter.complete();
          break;
        case 'ice-candidate':
          final session = clientMap[clientId]?.session;
          if (session == null) break;
          await session.describeCompleter.future;
          final pc = session.peerConnection;
          await pc.addCandidate(
            RTCIceCandidate(
              payload['candidate'],
              payload['sdpMid'],
              payload['sdpMLineIndex'],
            ),
          );
          break;
        default:
          break;
      }
    });

    this.socket = socket;
    socket.connect();
  }

  Future<RtcSession> _createSession(String clientId) async {
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
    pc.onIceCandidate = (candidate) async {
      if (candidate.candidate != null) {
        await _sendExchangeData(clientId, {
          'type': 'ice-candidate',
          'payload': candidate.toMap(),
        });
      }
    };
    pc.onConnectionState = (state) {
      debugPrint('connection state $state');
    };

    return RtcSession(peerConnection: pc);
  }

  Future<void> _sendExchangeData(String clientId, Map data) async {
    final member = clientMap[clientId];

    final wrapper = await SignHelper.wrap(
      scope,
      jsonEncode(data).codeUnits,
      encryptTarget: member!.snapshot.index,
    );
    socket.emit('exchange', {
      'clientId': clientId,
      'wrapper': base64Encode(wrapper.writeToBuffer()),
    });
  }

  @override
  void dispose() {
    socket.dispose();
    for (final client in clientMap.values) {
      client.dispose();
    }
    super.dispose();
  }
}
