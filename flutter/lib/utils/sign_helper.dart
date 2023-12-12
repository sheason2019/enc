import 'package:sheason_chat/cyprto/crypto_utils.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class SignHelper {
  SignHelper._();

  static Future<SignWrapper> wrap(
    Scope scope,
    List<int> buffer, {
    ContentType contentType = ContentType.CONTENT_BUFFER,
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
}
