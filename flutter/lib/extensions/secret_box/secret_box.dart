import 'package:cryptography/cryptography.dart';
import 'package:ENC/prototypes/core.pb.dart';

extension SecretBoxExtension on SecretBox {
  PortableSecretBox toPortable() {
    return PortableSecretBox()
      ..cipherData = cipherText
      ..nonce = nonce
      ..mac = mac.bytes;
  }
}
