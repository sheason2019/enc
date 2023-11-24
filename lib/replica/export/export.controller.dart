import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheason_chat/cyprto/crypto_keypair.dart';
import 'package:sheason_chat/cyprto/crypto_utils.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ExportReplicaController extends GetxController {
  final scanned = false.obs;
  final socketId = ''.obs;
  final verifyCode = ''.obs;
  final pageController = PageController();
  late Socket socket;
  final Scope scope;

  ExportReplicaController({required this.scope});

  late String _targetSocketId;
  late AccountIndex _targetAccountIndex;

  createSocket() {
    final socket = io(
      'http://192.168.31.174',
      OptionBuilder()
          .setPath('/replica')
          .setTransports(['websocket'])
          .enableForceNewConnection()
          .disableAutoConnect()
          .build(),
    );
    socket.on('pull', (data) {
      if (scanned.value) return;

      final socketId = data['socketId'];
      final account = AccountIndex.fromBuffer(base64Decode(data['account']));
      scanned.value = true;
      _targetSocketId = socketId;
      _targetAccountIndex = account;

      socket.emit('push', {
        'socketId': _targetSocketId,
        'account': base64Encode(scope.snapshot.value.writeToBuffer()),
      });
    });
    socket.on('verify-code', (data) async {
      final secretBox = SecretBox(
        base64Decode(data['cipherText']),
        nonce: base64Decode(data['nonce']),
        mac: Mac(base64Decode(data['mac'])),
      );
      final decrypt = await CryptoUtils.decrypt(
        CryptoKeyPair.fromSecret(scope.secret.value),
        _targetAccountIndex.ecdhPubKey,
        secretBox,
      );
      final verifyCode = String.fromCharCodes(decrypt);
      this.verifyCode.value = verifyCode;
      pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    });
    socket.onConnect((data) {
      socketId.value = socket.id!;
    });
    this.socket = socket;
    socket.connect();
  }

  Future<void> handleTransport() async {
    final secretBox = await CryptoUtils.encrypt(
      CryptoKeyPair.fromSecret(scope.secret.value),
      _targetAccountIndex.ecdhPubKey,
      scope.secret.value.writeToBuffer(),
    );

    socket.emit('secret', {
      'socketId': _targetSocketId,
      'cipherText': base64Encode(secretBox.cipherText),
      'nonce': base64Encode(secretBox.nonce),
      'mac': base64Encode(secretBox.mac.bytes),
    });
    Get.back();
  }

  @override
  void onInit() {
    createSocket();
    super.onInit();
  }

  @override
  void onClose() {
    socket.dispose();
    pageController.dispose();
    super.onClose();
  }
}
