import 'package:cryptography/cryptography.dart';
import 'package:sheason_chat/cyprto/crypto_keypair.dart';
import 'package:sheason_chat/cyprto/crypto_utils.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';

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
