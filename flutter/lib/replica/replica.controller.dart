import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ENC/cyprto/crypto_keypair.dart';
import 'package:ENC/cyprto/crypto_utils.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/replica/replica.view.dart';
import 'package:ENC/scope/scope.collection.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:socket_io_client/socket_io_client.dart';

enum ReplicaStatus {
  pending,
  confirm,
  success,
}

class ReplicaController extends ChangeNotifier {
  final Scope? scope;
  final ReplicaDataDirection dataDirection;
  final ReplicaConnDirection connDirection;
  final String url;
  final ScopeCollection collection;
  final statusNotifier = ValueNotifier(ReplicaStatus.pending);

  late CryptoKeyPair keypair;
  AccountSnapshot? self;
  AccountSnapshot? target;

  String? namespace;
  Object? error;

  ReplicaController({
    this.scope,
    this.namespace,
    required this.url,
    required this.dataDirection,
    required this.connDirection,
    required this.collection,
  });

  Socket? socket;

  initSelfSnapshotAndKeypair() async {
    if (dataDirection == ReplicaDataDirection.push) {
      keypair = CryptoKeyPair.fromSecret(scope!.secret);
      self = scope!.snapshot;
    } else {
      keypair = await CryptoUtils.generate();
      final index = AccountIndex()
        ..signPubKey = keypair.signPubKey
        ..ecdhPubKey = keypair.ecdhPubKey;
      self = AccountSnapshot()..index = index;
    }
  }

  Future<void> start() async {
    final socket = io(
      url,
      OptionBuilder()
          .setPath('/replica')
          .setTransports(['websocket'])
          .enableForceNewConnection()
          .disableAutoConnect()
          .build(),
    );

    await initSelfSnapshotAndKeypair();

    if (connDirection == ReplicaConnDirection.host) {
      registHost(socket);
    } else {
      registConnect(socket, namespace!);
    }

    socket.on('error', (data) {
      statusNotifier.value = ReplicaStatus.pending;
      error = data;
      notifyListeners();
      socket.dispose();
      this.socket = null;
    });

    this.socket = socket;
    socket.connect();
  }

  void registHost(Socket socket) {
    socket.onConnect((data) {
      socket.emit('create-namespace');
    });
    socket.on('namespace', (data) {
      namespace = data;
      notifyListeners();
    });
    socket.on('join-namespace', (data) {
      final snapshot = AccountSnapshot.fromBuffer(
        base64Decode(data['snapshot']),
      );
      socket.emit('exchange', {
        'type': 'snapshot',
        'snapshot': base64Encode(self!.writeToBuffer()),
      });
      target = snapshot;
      statusNotifier.value = ReplicaStatus.confirm;
      notifyListeners();
    });
    socket.on('exchange', (data) {
      switch (data['type']) {
        case 'secret':
          return handleReceiveSecret(data);
        default:
          return;
      }
    });
  }

  void registConnect(Socket socket, String namespace) {
    socket.onConnect((data) async {
      socket.emit('join-namespace', {
        'namespace': namespace,
        'snapshot': base64Encode(self!.writeToBuffer()),
      });
    });
    socket.on('exchange', (data) {
      switch (data['type']) {
        case 'snapshot':
          final snapshot = AccountSnapshot.fromBuffer(
            base64Decode(data['snapshot']),
          );
          target = snapshot;
          statusNotifier.value = ReplicaStatus.confirm;
          notifyListeners();
          return;
        case 'secret':
          return handleReceiveSecret(data);
        default:
          return;
      }
    });
  }

  // 由 Pusher 发送
  void handleSendSecret() async {
    final secretBox = await CryptoUtils.encrypt(
      scope!,
      target!.index,
      scope!.secret.writeToBuffer(),
    );
    socket!.emit('exchange', {
      'type': 'secret',
      'secretBox': base64Encode(secretBox.writeToBuffer()),
    });
    statusNotifier.value = ReplicaStatus.success;
  }

  void handleReceiveSecret(Map data) async {
    final portableSecretBox = PortableSecretBox.fromBuffer(
      base64Decode(data['secretBox']),
    );
    final plainData = await CryptoUtils.secretDecrypt(
      AccountSecret()
        ..signPrivKey = keypair.signPrivKey
        ..signPubKey = keypair.signPubKey
        ..ecdhPrivKey = keypair.ecdhPrivKey
        ..ecdhPubKey = keypair.ecdhPubKey,
      portableSecretBox,
    );
    final secret = AccountSecret.fromBuffer(plainData);

    var scope = await collection.findScope(secret.signPubKey);
    scope ??= await collection.createScopeBySecret(secret);
    scope.handleSetSnapshot(target!);

    statusNotifier.value = ReplicaStatus.success;
  }

  @override
  void dispose() {
    socket?.dispose();
    statusNotifier.dispose();
    super.dispose();
  }
}
