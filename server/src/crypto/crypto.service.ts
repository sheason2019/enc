import { Injectable } from '@nestjs/common';
import {
  ED25519KeyPairOptions,
  X25519KeyPairOptions,
  createCipheriv,
  createDecipheriv,
  createPrivateKey,
  createPublicKey,
  diffieHellman,
  generateKeyPairSync,
  randomBytes,
  sign,
  verify,
} from 'crypto';
import { sheason_chat } from '../prototypes';

@Injectable()
export class CryptoService {
  generate(): sheason_chat.AccountSecret {
    const ecdhOptions: X25519KeyPairOptions<'jwk', 'jwk'> = {
      publicKeyEncoding: {
        type: 'spki',
        format: 'jwk',
      },
      privateKeyEncoding: {
        type: 'pkcs8',
        format: 'jwk',
      },
    };
    const ecdhKeypair = generateKeyPairSync('x25519', ecdhOptions);
    const signOptions: ED25519KeyPairOptions<'jwk', 'jwk'> = {
      publicKeyEncoding: {
        type: 'spki',
        format: 'jwk',
      },
      privateKeyEncoding: {
        type: 'pkcs8',
        format: 'jwk',
      },
    };
    const signKeypair = generateKeyPairSync('ed25519', signOptions);
    return sheason_chat.AccountSecret.create({
      ecdhPubKey: ecdhKeypair.publicKey['x'],
      ecdhPrivKey: ecdhKeypair.privateKey['d'],
      signPubKey: signKeypair.publicKey['x'],
      signPrivKey: signKeypair.privateKey['d'],
    });
  }

  generateSecret() {
    return randomBytes(32);
  }

  #sharedSecret(secret: sheason_chat.IAccountSecret, targetPubKey: string) {
    return diffieHellman({
      publicKey: createPublicKey({
        format: 'jwk',
        key: { crv: 'X25519', x: targetPubKey, kty: 'OKP' },
      }),
      privateKey: createPrivateKey({
        format: 'jwk',
        key: {
          crv: 'X25519',
          d: secret.ecdhPrivKey,
          x: secret.ecdhPubKey,
          kty: 'OKP',
        },
      }),
    });
  }

  encrypt(
    secret: sheason_chat.IAccountSecret,
    target: sheason_chat.IAccountIndex,
    originData: Buffer,
  ): sheason_chat.IPortableSecretBox {
    const sharedSecret = this.#sharedSecret(secret, target.ecdhPubKey);
    const box = this.secretEncrypt(sharedSecret, originData);
    box.sender = {
      ecdhPubKey: secret.ecdhPubKey,
      signPubKey: secret.signPubKey,
    };
    box.receiver = target;
    box.encryptType = sheason_chat.EncryptType.ENCRYPT_TYPE_SHARED_SECRET;

    return box;
  }

  decrypt(
    secret: sheason_chat.IAccountSecret,
    secretBox: sheason_chat.IPortableSecretBox,
  ) {
    let target: sheason_chat.IAccountIndex;
    if (secret.signPubKey === secretBox.sender.signPubKey) {
      target = secretBox.receiver;
    } else {
      target = secretBox.sender;
    }
    const sharedSecret = this.#sharedSecret(secret, target.ecdhPubKey);
    return this.secretDecrypt(sharedSecret, secretBox);
  }

  secretEncrypt(
    key: Buffer,
    originData: Buffer,
  ): sheason_chat.IPortableSecretBox {
    const nonce = randomBytes(12);
    const cipher = createCipheriv('chacha20-poly1305', key, nonce, {
      authTagLength: 16,
    });
    const cipherData = Buffer.concat([
      cipher.update(originData),
      cipher.final(),
    ]);
    const mac = cipher.getAuthTag();

    return {
      cipherData,
      nonce,
      mac,
      encryptType: sheason_chat.EncryptType.ENCRYPT_TYPE_DECLARED_SECRET,
    };
  }
  secretDecrypt(key: Buffer, secretBox: sheason_chat.IPortableSecretBox) {
    const decipher = createDecipheriv(
      'chacha20-poly1305',
      key,
      secretBox.nonce,
      {
        authTagLength: 16,
      },
    );
    decipher.setAuthTag(secretBox.mac);
    return Buffer.concat([
      decipher.update(secretBox.cipherData),
      decipher.final(),
    ]);
  }

  createSignature(
    secret: sheason_chat.AccountSecret,
    originData: Buffer,
  ): sheason_chat.SignWrapper {
    const key = createPrivateKey({
      format: 'jwk',
      key: {
        d: secret.signPrivKey,
        x: secret.signPubKey,
        crv: 'Ed25519',
        kty: 'OKP',
      },
    });
    const signData = sign(null, originData, {
      key,
      format: 'jwk',
    });
    return sheason_chat.SignWrapper.create({
      buffer: originData,
      signer: { signPubKey: secret.signPubKey, ecdhPubKey: secret.ecdhPubKey },
      sign: signData,
      createdAt: new Date().getTime(),
    });
  }

  verifySignature(wrapper: sheason_chat.SignWrapper) {
    // TODO: 通过 CreatedAt 校验 Wrapper 是否过期，默认时间为 3min

    return verify(
      null,
      wrapper.buffer,
      {
        key: { x: wrapper.signer.signPubKey, crv: 'Ed25519', kty: 'OKP' },
        format: 'jwk',
      },
      wrapper.sign,
    );
  }
}
