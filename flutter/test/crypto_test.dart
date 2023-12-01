// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:sheason_chat/cyprto/crypto_utils.dart';

void main() {
  test('Counter increments smoke test', () async {
    // ECDH Test
    final alice = await CryptoUtils.generate();
    final bob = await CryptoUtils.generate();

    print(
      'alice:: '
      '${alice.signPubKey} '
      '${alice.signPrivKey} '
      '${alice.ecdhPubKey} '
      '${alice.ecdhPrivKey}',
    );

    final originData = 'alice <3 bob'.codeUnits;
    final cipherData = await CryptoUtils.encrypt(
      alice,
      bob.ecdhPubKey,
      originData,
    );
    final decryptData = await CryptoUtils.decrypt(
      bob,
      alice.ecdhPubKey,
      cipherData,
    );
    assert(decryptData.length == originData.length);
    for (var i = 0; i < decryptData.length; i++) {
      assert(decryptData[i] == originData[i]);
    }

    // SIGN test
    final sign = await CryptoUtils.createSignature(alice, originData);
    assert(await CryptoUtils.verifySignature(originData, sign));
  });
}
