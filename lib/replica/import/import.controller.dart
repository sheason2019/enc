import 'dart:convert';
import 'dart:math';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheason_chat/accounts/accounts.controller.dart';
import 'package:sheason_chat/cyprto/crypto_keypair.dart';
import 'package:sheason_chat/cyprto/crypto_utils.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ImportReplicaController extends GetxController {
  final String url;
  final String socketId;
  ImportReplicaController({
    required this.url,
    required this.socketId,
  });

  final pageController = PageController();

  final snapshot = AccountSnapshot().obs;
  late Socket socket;
  late CryptoKeyPair keypair;
  final verifyCode = ''.obs;

  handleConnect() async {
    final keypair = await CryptoUtils.generate();
    this.keypair = keypair;

    final account = AccountIndex()
      ..ecdhPubKey = keypair.ecdhPubKey
      ..signPubKey = keypair.signPubKey;

    final socket = io(
      url,
      OptionBuilder()
          .setPath('/replica')
          .setTransports(['websocket'])
          .enableForceNewConnection()
          .disableAutoConnect()
          .build(),
    );

    socket.onConnect((data) {
      socket.emit(
        'pull',
        {
          'socketId': socketId,
          'account': base64Encode(account.writeToBuffer()),
        },
      );
    });
    socket.on('push', (data) {
      final account = AccountSnapshot.fromBuffer(base64Decode(data['account']));
      snapshot.value = account;
      pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    });
    socket.on('secret', (data) async {
      final secretBox = SecretBox(
        base64Decode(data['cipherText']),
        nonce: base64Decode(data['nonce']),
        mac: Mac(base64Decode(data['mac'])),
      );
      final decrypt = await CryptoUtils.decrypt(
        keypair,
        snapshot.value.index.ecdhPubKey,
        secretBox,
      );
      final secret = AccountSecret.fromBuffer(decrypt);
      final controller = Get.find<AccountsController>();
      await controller.createAccountBySecret(secret);
      Get.back();
    });

    socket.connect();
    this.socket = socket;
  }

  Future<void> handleRequest() async {
    final verifyCode = <int>[];
    for (var i = 0; i < 6; i++) {
      verifyCode.add(Random().nextInt(10));
    }
    final codeStr = verifyCode.join();
    this.verifyCode.value = codeStr;

    final secretBox = await CryptoUtils.encrypt(
      keypair,
      snapshot.value.index.ecdhPubKey,
      codeStr.codeUnits,
    );

    socket.emit('verify-code', {
      'socketId': socketId,
      'cipherText': base64Encode(secretBox.cipherText),
      'nonce': base64Encode(secretBox.nonce),
      'mac': base64Encode(secretBox.mac.bytes),
    });
  }

  @override
  void onInit() {
    handleConnect();
    super.onInit();
  }

  @override
  void onClose() {
    socket.close();
    super.onClose();
  }
}
