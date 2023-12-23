import 'dart:convert';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/schema/database.dart';
import 'package:ENC/scope/scope.model.dart';
import 'package:ENC/utils/sign_helper.dart';

class OperationCipher {
  OperationCipher._();

  static Future<List<Map<String, dynamic>>> encrypt(
    Scope scope,
    List<Operation> operations,
  ) async {
    final output = <Map<String, dynamic>>[];
    for (final operation in operations) {
      final wrapper = await SignHelper.wrap(
        scope,
        operation.info.writeToBuffer(),
        contentType: ContentType.CONTENT_OPERATION,
        encryptTarget: scope.snapshot.index,
      );
      output.add({
        'clientId': operation.clientId,
        'clock': operation.clock,
        'data': base64Encode(wrapper.writeToBuffer()),
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
      final decryptBuffer = await SignHelper.unwrap(scope, data);

      final output = PortableOperation.fromBuffer(decryptBuffer);
      outputs.add(output);
    }
    return outputs;
  }
}
