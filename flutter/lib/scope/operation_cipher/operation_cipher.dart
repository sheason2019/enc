import 'dart:convert';
import 'dart:developer';

import 'package:cryptography/cryptography.dart';
import 'package:sheason_chat/cyprto/crypto_keypair.dart';
import 'package:sheason_chat/cyprto/crypto_utils.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class OperationCipher {
  OperationCipher._();

  static Future<List<Map<String, dynamic>>> encrypt(
    Scope scope,
    List<Operation> operations,
  ) async {
    final keypair = CryptoKeyPair.fromSecret(scope.secret);
    final output = <Map<String, dynamic>>[];
    for (final operation in operations) {
      final secretBox = await CryptoUtils.encrypt(
        scope,
        scope.snapshot.index,
        operation.info.writeToBuffer(),
      );
      final buffer = secretBox.writeToBuffer();
      final sign = await CryptoUtils.createSignature(keypair, buffer);
      final signWrapper = SignWrapper()
        ..buffer = buffer
        ..contentType = ContentType.CONTENT_OPERATION
        ..signer = scope.snapshot.index
        ..encrypt = true
        ..sign = sign.bytes;
      output.add({
        'clientId': operation.clientId,
        'clock': operation.clock,
        'data': base64Encode(signWrapper.writeToBuffer()),
      });
    }

    return output;
  }

  static Future<List<PortableOperation>> decrypt(
    Scope scope,
    List operations,
  ) async {
    final outputs = <PortableOperation>[];
    for (final operation in operations) {
      final data = SignWrapper.fromBuffer(
        base64Decode(operation['data']),
      );
      final valid = await CryptoUtils.verifySignature(
        data.buffer,
        Signature(
          data.sign,
          publicKey: CryptoKeyPair.createSignPubKey(
            data.signer.signPubKey,
          )!,
        ),
      );
      if (!valid) {
        log('[WARN] invalid operation signature');
        continue;
      }
      final secretBox = PortableSecretBox.fromBuffer(
        data.buffer,
      );
      final decryptBuffer = await CryptoUtils.decrypt(
        scope,
        secretBox,
      );

      final output = PortableOperation.fromBuffer(decryptBuffer);
      outputs.add(output);
    }
    return outputs;
  }
}
