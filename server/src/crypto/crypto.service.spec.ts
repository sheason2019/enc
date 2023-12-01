import { Test, TestingModule } from '@nestjs/testing';
import { CryptoService } from './crypto.service';

describe('CryptoService', () => {
  let cryptoService: CryptoService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [CryptoService],
    }).compile();

    cryptoService = module.get<CryptoService>(CryptoService);
  });

  it('should be defined', () => {
    expect(cryptoService).toBeDefined();
  });

  it('main test', async () => {
    // 生成密钥对
    const alice = cryptoService.generate();
    const bob = cryptoService.generate();
    const testBuffer = Buffer.from('test');

    // 测试加解密
    const secretBox = cryptoService.encrypt(alice, bob.ecdhPubKey, testBuffer);
    console.log(secretBox);
    const decryptBuf = cryptoService.decrypt(bob, alice.ecdhPubKey, secretBox);
    expect(decryptBuf.equals(testBuffer)).toBe(true);
  });

  it('long data test', async () => {
    const alice = cryptoService.generate();
    const bob = cryptoService.generate();
    const dataStr = `CgAaACIkChD4wB2+ZfzKsphECg+IM9LSEhBodHRwOi8vbG9jYWxob3N0Kl4SJAoQ+MAdvmX8yrKYRAoPiDPS0hIQaHR0cDovL2xvY2FsaG9zdBIkChBgtlPsLNfJkDVa8UZilyJLEhBodHRwOi8vbG9jYWxob3N0GhBodHRwOi8vbG9jYWxob3N0OqoDLS0tLS1CRUdJTiBSU0EgUFVCTElDIEtFWS0tLS0tCk1JSUJDZ0tDQVFFQXFFZXRlTVVkVVQ3S0NvL0ZFckplTzYwRXlQUGtoTUFnY3NhUkEycmJOcWRqZzFDeGJlVU8KdlhucWEvWnppL3Jjb2crbmdYRHRlcVJCQ0MxdVAwZUZXYzczZXFaT3lwb1k0K3ZXc0tqejhWZHpYdWtJV3o4RApDTFBNMDBiWVhVcUpFTStrS2MxNVo5Tng0WUVneW1BS2ZyeFAxeUloRHd1ZHdTRy9DNk1Gd1hlaklMNnRxSlliCituU0ZCaHF4bVgvQW5MYzhNbmd0cHh4MCs5Y1F1QUtkTVI2MVkxbllIdUxhVzRmeEQvK0xnZVNRWHN3OU1pVTMKNjIvWGdDNThrdDIyVFNOeWJXMEZ0TU5Zem5nYmZtdWZSTW5yaFIwcGJSRFp2MlgvMHJ1d1Y5Z3ZSMUhTWWo5OQpIU2ZVc20wN0VyV1dMdnVtTG1BemhSM1g3a0pDNUFDNlJRSURBUUFCCi0tLS0tRU5EIFJTQSBQVUJMSUMgS0VZLS0tLS0K`;
    const originBuf = Buffer.from(dataStr, 'base64');
    const cipherBuf = cryptoService.encrypt(alice, bob.ecdhPubKey, originBuf);
    const decryptBuf = cryptoService.decrypt(bob, alice.ecdhPubKey, cipherBuf);
    expect(decryptBuf.equals(originBuf)).toBe(true);
  });

  it('test signature', async () => {
    const alice = cryptoService.generate();
    const dataStr = 'Test';
    const originData = Buffer.from(dataStr);
    const signature = cryptoService.createSignature(alice, originData);
    const verify = cryptoService.verifySignature(signature);
    expect(verify).toBe(true);
  });
});
