import 'package:cryptography/cryptography.dart';
import 'package:ENC/cyprto/crypto_keypair.dart';
import 'package:ENC/cyprto/crypto_utils.dart';
import 'package:ENC/prototypes/core.pb.dart';

extension SignWrapperExtension on SignWrapper {
  Future<bool> verify() async {
    return CryptoUtils.verifySignature(
      buffer,
      Signature(
        sign,
        publicKey: CryptoKeyPair.createSignPubKey(signer.signPubKey)!,
      ),
    );
  }
}
