// 使用 x25519 作为用户 ID
import 'package:cryptography/cryptography.dart';
import 'package:drift/drift.dart';
import 'package:jwk/jwk.dart';
import 'package:ENC/cyprto/crypto_keypair.dart';
import 'package:ENC/extensions/portable_secret_box/portable_secret_box.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/scope/scope.model.dart';

class CryptoUtils {
  static Future<SecretKey> _sharedSecret(
    CryptoKeyPair keypair,
    String targetPubKey,
  ) async {
    final algorithm = X25519();
    final wand = await algorithm.newKeyExchangeWandFromKeyPair(
      keypair.getEcdhKeypair(),
    );
    final pubKey = Jwk.fromJson({
      'crv': 'X25519',
      'kty': 'OKP',
      'x': targetPubKey,
    }).toPublicKey()!;
    return wand.sharedSecretKey(
      remotePublicKey: pubKey,
    );
  }

  static Future<CryptoKeyPair> generate() async {
    final x25510 = X25519();
    final keyPair = await x25510.newKeyPair();

    final ed25519 = Ed25519();
    final edKeyPair = await ed25519.newKeyPair();

    final ecdhKeypair = (await Jwk.fromKeyPair(keyPair)).toJson();
    final signKeypair = (await Jwk.fromKeyPair(edKeyPair)).toJson();

    return CryptoKeyPair(
      ecdhPubKey: ecdhKeypair['x'].toString(),
      ecdhPrivKey: ecdhKeypair['d'].toString(),
      signPubKey: signKeypair['x'].toString(),
      signPrivKey: signKeypair['d'].toString(),
    );
  }

  static Future<PortableSecretBox> encrypt(
    Scope scope,
    AccountIndex target,
    List<int> plainData,
  ) async {
    final keypair = CryptoKeyPair.fromSecret(scope.secret);

    final secret = await _sharedSecret(keypair, target.ecdhPubKey);
    final algorithm = Chacha20.poly1305Aead();
    final wand = await algorithm.newCipherWandFromSecretKey(secret);
    final secretBox = await wand.encrypt(plainData);

    return PortableSecretBox()
      ..encryptType = EncryptType.ENCRYPT_TYPE_SHARED_SECRET
      ..cipherData = secretBox.cipherText
      ..nonce = secretBox.nonce
      ..mac = secretBox.mac.bytes
      ..sender = scope.snapshot.index
      ..receiver = target;
  }

  static Future<List<int>> decrypt(
    Scope scope,
    PortableSecretBox secretBox,
  ) async {
    if (secretBox.encryptType == EncryptType.ENCRYPT_TYPE_SHARED_SECRET) {
      return secretDecrypt(scope.secret, secretBox);
    }
    if (secretBox.encryptType == EncryptType.ENCRYPT_TYPE_DECLARED_SECRET) {
      final agent = secretBox.findAgent(scope.secret);
      final select = scope.db.conversations.select();
      select.where((tbl) => tbl.signPubkey.equals(agent.signPubKey));
      final conversation = await select.getSingle();
      final key = conversation.info.declaredSecrets[secretBox.declaredKey];
      final algorithm = Chacha20.poly1305Aead();
      final wand = await algorithm.newCipherWandFromSecretKey(SecretKey(key));
      return wand.decrypt(
        SecretBox(
          secretBox.cipherData,
          nonce: secretBox.nonce,
          mac: Mac(secretBox.mac),
        ),
      );
    }
    throw UnimplementedError();
  }

  static Future<List<int>> secretDecrypt(
    AccountSecret secret,
    PortableSecretBox secretBox,
  ) async {
    final keypair = CryptoKeyPair.fromSecret(secret);
    final agent = secretBox.findAgent(secret);

    final secretKey = await _sharedSecret(keypair, agent.ecdhPubKey);
    final algorithm = Chacha20.poly1305Aead();
    final wand = await algorithm.newCipherWandFromSecretKey(secretKey);
    return wand.decrypt(
      SecretBox(
        secretBox.cipherData,
        nonce: secretBox.nonce,
        mac: Mac(secretBox.mac),
      ),
    );
  }

  static Future<Signature> createSignature(
    Scope scope,
    List<int> originData,
  ) async {
    final keypair = CryptoKeyPair.fromSecret(scope.secret);
    final algorithm = Ed25519();
    final key = keypair.getSignKeypair();
    final wand = await algorithm.newSignatureWandFromKeyPair(key);
    return wand.sign(originData);
  }

  static Future<bool> verifySignature(
    List<int> originData,
    Signature signature,
  ) async {
    final algorithm = Ed25519();
    return algorithm.verify(originData, signature: signature);
  }
}
