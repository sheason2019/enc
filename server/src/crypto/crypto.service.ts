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

export interface SecretBox {
  cipherData: Buffer;
  nonce: Buffer;
  mac: Buffer;
}

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

  #sharedSecret(secret: sheason_chat.AccountSecret, targetPubKey: string) {
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
    secret: sheason_chat.AccountSecret,
    ecdhPubKey: string,
    originData: Buffer,
  ): SecretBox {
    const sharedSecret = this.#sharedSecret(secret, ecdhPubKey);
    return this.secretEncrypt(sharedSecret, originData);
  }
  decrypt(
    secret: sheason_chat.AccountSecret,
    ecdhPubKey: string,
    secretBox: SecretBox,
  ) {
    const sharedSecret = this.#sharedSecret(secret, ecdhPubKey);
    return this.secretDecrypt(sharedSecret, secretBox);
  }

  secretEncrypt(key: Buffer, originData: Buffer): SecretBox {
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
    };
  }
  secretDecrypt(key: Buffer, secretBox: SecretBox) {
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
    });
  }

  verifySignature(wrapper: sheason_chat.SignWrapper) {
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
