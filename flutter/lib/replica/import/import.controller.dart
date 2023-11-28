import 'dart:convert';
import 'dart:math';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheason_chat/scope/scope.collection.dart';
import 'package:sheason_chat/cyprto/crypto_keypair.dart';
import 'package:sheason_chat/cyprto/crypto_utils.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ImportReplicaController extends ChangeNotifier {
  final String url;
  final String socketId;
  ImportReplicaController({
    required this.url,
    required this.socketId,
  });

  final pageController = PageController();

  var snapshot = AccountSnapshot();
  late Socket socket;
  late CryptoKeyPair keypair;
  var verifyCode = '';

  handleConnect(BuildContext context) async {
    final controller = context.read<ScopeCollection>();
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
      final snapshot =
          AccountSnapshot.fromBuffer(base64Decode(data['account']));
      this.snapshot = snapshot;
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
        snapshot.index.ecdhPubKey,
        secretBox,
      );
      final secret = AccountSecret.fromBuffer(decrypt);
      await controller.createAccountBySecret(secret);
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
    this.verifyCode = codeStr;

    final secretBox = await CryptoUtils.encrypt(
      keypair,
      snapshot.index.ecdhPubKey,
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
  void dispose() {
    socket.dispose();
    super.dispose();
  }
}
