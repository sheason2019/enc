import {
  Put,
  Body,
  Param,
  Controller,
  UseInterceptors,
  HttpException,
} from '@nestjs/common';
import { AccountService } from './account.service';
import { NoFilesInterceptor } from '@nestjs/platform-express';
import { sheason_chat } from 'src/prototypes';
import { CryptoService } from 'src/crypto/crypto.service';

@Controller()
export class AccountController {
  constructor(
    private readonly accountService: AccountService,
    private readonly cryptoService: CryptoService,
  ) {}

  @Put(':signPubkey')
  @UseInterceptors(NoFilesInterceptor())
  async handlePut(
    @Body() body: { snapshot: string },
    @Param('signPubkey') signPubkey: string,
  ): Promise<string> {
    const warpper = sheason_chat.SignWrapper.decode(
      Buffer.from(body.snapshot, 'base64'),
    );
    const valid = this.cryptoService.verifySignature(warpper);
    if (!valid) throw new HttpException('Verify signature failed', 403);

    const snapshot = sheason_chat.AccountSnapshot.decode(warpper.buffer);
    if (snapshot.index.signPubKey !== signPubkey) {
      throw new HttpException(
        'URL Params sign public key not valid. except ' +
          snapshot.index.signPubKey +
          ' but ' +
          signPubkey,
        403,
      );
    }

    await this.accountService.put(snapshot);
    return signPubkey;
  }
}
