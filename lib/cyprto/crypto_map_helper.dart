import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:sheason_chat/cyprto/crypto_keypair.dart';
import 'package:sheason_chat/cyprto/crypto_utils.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';

class CryptoMapHelper {
  CryptoMapHelper._();

  static Future<Map> encryptMap(AccountSecret secret, Map map) async {
    final keypair = CryptoKeyPair.fromSecret(secret);
    final secretBox = await CryptoUtils.encrypt(
      keypair,
      keypair.ecdhPubKey,
      jsonEncode(map).codeUnits,
    );

    return {
      'cipherText': base64Encode(secretBox.cipherText),
      'nonce': base64Encode(secretBox.nonce),
      'mac': base64Encode(secretBox.mac.bytes),
    };
  }

  static Future<Map> decryptMap(AccountSecret secret, Map map) async {
    final keypair = CryptoKeyPair.fromSecret(secret);
    final secretBox = SecretBox(
      base64Decode(map['cipherText']),
      nonce: base64Decode(map['nonce']),
      mac: Mac(base64Decode(map['mac'])),
    );
    return jsonDecode(
      String.fromCharCodes(
        await CryptoUtils.decrypt(keypair, secret.ecdhPubKey, secretBox),
      ),
    );
  }
}
