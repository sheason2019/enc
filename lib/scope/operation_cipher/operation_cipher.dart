import 'package:cryptography/cryptography.dart';
import 'package:sheason_chat/cyprto/crypto_keypair.dart';
import 'package:sheason_chat/cyprto/crypto_utils.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class OperationCipher {
  OperationCipher._();

  static Future<List<PortableOperation>> encrypt(
    Scope scope,
    List<Operation> operations,
  ) async {
    final keypair = CryptoKeyPair.fromSecret(scope.secret);
    final output = <PortableOperation>[];
    for (final operation in operations) {
      final portable = PortableOperation()
        ..clientId = operation.clientId
        ..clock = operation.clock;
      final secretBox = await CryptoUtils.encrypt(
        keypair,
        keypair.ecdhPubKey,
        operation.payload.codeUnits,
      );
      portable.secretBox = PortableSecretBox()
        ..cipherData = secretBox.cipherText
        ..nonce = secretBox.nonce
        ..mac = secretBox.mac.bytes;
      output.add(portable);
    }

    return output;
  }

  static Future<void> decrypt(
    Scope scope,
    List<PortableOperation> operations,
  ) async {
    final keypair = CryptoKeyPair.fromSecret(scope.secret);
    for (final operation in operations) {
      final payloadBytes = await CryptoUtils.decrypt(
        keypair,
        keypair.ecdhPubKey,
        SecretBox(
          operation.secretBox.cipherData,
          nonce: operation.secretBox.nonce,
          mac: Mac(operation.secretBox.mac),
        ),
      );
      operation.payload = String.fromCharCodes(payloadBytes);
    }
  }
}
