import 'package:jwk/jwk.dart';
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

  static PublicKey? createSignPubKey(String pubkey) => Jwk.fromJson({
        'crv': 'Ed25519',
        'kty': 'OKP',
        'x': pubkey,
      }).toPublicKey();
  static KeyPair createSignKeypair(String pubkey, String privkey) =>
      Jwk.fromJson({
        'crv': 'Ed25519',
        'kty': 'OKP',
        'x': pubkey,
        'd': privkey,
      }).toKeyPair();
  static PublicKey? createEcdhPubKey(String pubkey) => Jwk.fromJson({
        'crv': 'X25519',
        'kty': 'OKP',
        'x': pubkey,
      }).toPublicKey();
  static KeyPair createEcdhKeypair(String pubkey, String privkey) =>
      Jwk.fromJson({
        'crv': 'X25519',
        'kty': 'OKP',
        'x': pubkey,
        'd': privkey,
      }).toKeyPair();

  factory CryptoKeyPair.fromSecret(AccountSecret secret) {
    return CryptoKeyPair(
      signPubKey: secret.signPubKey,
      signPrivKey: secret.signPrivKey,
      ecdhPubKey: secret.ecdhPubKey,
      ecdhPrivKey: secret.ecdhPrivKey,
    );
  }
}
