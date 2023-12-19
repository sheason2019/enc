import 'package:cryptography/cryptography.dart';
import 'package:sheason_chat/cyprto/crypto_keypair.dart';
import 'package:sheason_chat/cyprto/crypto_utils.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class SignHelper {
  SignHelper._();

  static Future<SignWrapper> wrap(
    Scope scope,
    List<int> buffer, {
    required ContentType contentType,
    AccountIndex? encryptTarget,
  }) async {
    if (encryptTarget == null) {
      final signature = await CryptoUtils.createSignature(scope, buffer);

      return SignWrapper()
        ..buffer = buffer
        ..sign = signature.bytes
        ..signer = scope.snapshot.index
        ..contentType = contentType
        ..encrypt = false;
    } else {
      final secret = await CryptoUtils.encrypt(scope, encryptTarget, buffer);
      final wrapperBuffer = secret.writeToBuffer();
      final signature = await CryptoUtils.createSignature(scope, wrapperBuffer);

      return SignWrapper()
        ..buffer = wrapperBuffer
        ..sign = signature.bytes
        ..signer = scope.snapshot.index
        ..contentType = contentType
        ..encrypt = true;
    }
  }

  static Future<List<int>> unwrap(
    Scope scope,
    SignWrapper wrapper,
  ) async {
    final valid = await CryptoUtils.verifySignature(
      wrapper.buffer,
      Signature(
        wrapper.sign,
        publicKey: CryptoKeyPair.createSignPubKey(
          wrapper.signer.signPubKey,
        )!,
      ),
    );
    if (!valid) {
      throw Exception('Verify signature failed');
    }

    if (wrapper.encrypt) {
      final secretBox = PortableSecretBox.fromBuffer(wrapper.buffer);
      return CryptoUtils.decrypt(scope, secretBox);
    } else {
      return wrapper.buffer;
    }
  }
}
