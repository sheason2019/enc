import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';

@immutable
class CryptoKeyPair {
  final String signPubKey;
  final String signPrivKey;
  final String ecdhPubKey;
  final String ecdhPrivKey;
  const CryptoKeyPair({
    required this.signPubKey,
    required this.signPrivKey,
    required this.ecdhPubKey,
    required this.ecdhPrivKey,
  });

  PublicKey getSignPubKey() => CryptoKeyPair.createSignPubKey(signPubKey)!;
  KeyPair getSignKeypair() => CryptoKeyPair.createSignKeypair(
        signPubKey,
        signPrivKey,
      );
  PublicKey getEcdhPubKey() => CryptoKeyPair.createEcdhPubKey(ecdhPubKey)!;
  KeyPair getEcdhKeypair() => CryptoKeyPair.createEcdhKeypair(
        ecdhPubKey,
        ecdhPrivKey,
      );

  static PublicKey? createSignPubKey(String pubkey) => SimplePublicKey(
        base64Decode(pubkey),
        type: KeyPairType.ed25519,
      );
  static KeyPair createSignKeypair(String pubkey, String privkey) =>
      SimpleKeyPairData(
        base64Decode(privkey),
        publicKey: SimplePublicKey(
          base64Decode(pubkey),
          type: KeyPairType.ed25519,
        ),
        type: KeyPairType.ed25519,
      );
  static PublicKey? createEcdhPubKey(String pubkey) => SimplePublicKey(
        base64Decode(pubkey),
        type: KeyPairType.x25519,
      );
  static KeyPair createEcdhKeypair(String pubkey, String privkey) =>
      SimpleKeyPairData(
        base64Decode(privkey),
        publicKey: SimplePublicKey(
          base64Decode(pubkey),
          type: KeyPairType.x25519,
        ),
        type: KeyPairType.x25519,
      );

  factory CryptoKeyPair.fromSecret(AccountSecret secret) {
    return CryptoKeyPair(
      signPubKey: secret.signPubKey,
      signPrivKey: secret.signPrivKey,
      ecdhPubKey: secret.ecdhPubKey,
      ecdhPrivKey: secret.ecdhPrivKey,
    );
  }
}
