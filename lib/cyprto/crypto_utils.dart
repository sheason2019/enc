// 使用 x25519 作为用户 ID
import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';
import 'package:sheason_chat/cyprto/crypto_keypair.dart';

class CryptoUtils {
  static Future<SecretKey> _sharedSecret(
    CryptoKeyPair keypair,
    String targetPubKey,
  ) async {
    final algorithm = X25519();
    final wand = await algorithm.newKeyExchangeWandFromKeyPair(
      keypair.getEcdhKeypair(),
    );
    final pubKey = SimplePublicKey(
      base64Decode(targetPubKey),
      type: KeyPairType.x25519,
    );
    return wand.sharedSecretKey(
      remotePublicKey: pubKey,
    );
  }

  static Future<CryptoKeyPair> generate() async {
    final x25510 = X25519();
    final keyPair = await x25510.newKeyPair();
    final ecdhPrivKey = await keyPair.extract();

    final ed25519 = Ed25519();
    final edKeyPair = await ed25519.newKeyPair();
    final signPrivKey = await edKeyPair.extract();

    return CryptoKeyPair(
      ecdhPubKey: base64UrlEncode(ecdhPrivKey.publicKey.bytes),
      ecdhPrivKey: base64UrlEncode(ecdhPrivKey.bytes),
      signPubKey: base64UrlEncode(signPrivKey.publicKey.bytes),
      signPrivKey: base64UrlEncode(signPrivKey.bytes),
    );
  }

  static Future<SecretBox> encrypt(
    CryptoKeyPair keypair,
    String targetEcdhPubkey,
    List<int> plainData,
  ) async {
    final secret = await _sharedSecret(keypair, targetEcdhPubkey);
    final algorithm = Chacha20.poly1305Aead();
    final wand = await algorithm.newCipherWandFromSecretKey(secret);
    return wand.encrypt(plainData);
  }

  static Future<List<int>> decrypt(
    CryptoKeyPair keypair,
    String targetEcdhPubkey,
    SecretBox box,
  ) async {
    final secret = await _sharedSecret(keypair, targetEcdhPubkey);
    final algorithm = Chacha20.poly1305Aead();
    final wand = await algorithm.newCipherWandFromSecretKey(secret);
    return wand.decrypt(box);
  }

  static Future<List<int>> secretDecrypt(
    Uint8List secret,
    SecretBox secretBox,
  ) async {
    return compute((args) async {
      final secret = args.$1;
      final secretBox = args.$2;

      final algorithm = Chacha20.poly1305Aead();
      final wand = await algorithm.newCipherWandFromSecretKey(
        SecretKey(secret),
      );
      return wand.decrypt(secretBox);
    }, (secret, secretBox));
  }

  static Future<Signature> createSignature(
    CryptoKeyPair keypair,
    List<int> originData,
  ) async {
    final algorithm = Ed25519();
    final key = keypair.getSignKeypair();
    final wand = await algorithm.newSignatureWandFromKeyPair(key);
    return wand.sign(originData);
  }

  static Future<bool> verifySignature(
    List<int> originData,
    Signature signature,
  ) async {
    final algorithm = Ed25519();
    return algorithm.verify(originData, signature: signature);
  }
}
