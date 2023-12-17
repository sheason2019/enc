import {
  Get,
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
import { prisma } from 'src/prisma/prisma';

@Controller('account')
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

    await this.accountService.put(
      snapshot,
      Buffer.from(warpper.buffer),
      Buffer.from(warpper.sign),
    );
    return signPubkey;
  }

  @Get(':signPubkey')
  async handleGet(@Param('signPubkey') signPubkey: string) {
    const account = await prisma.account.findFirst({
      where: {
        signPubkey,
      },
    });
    if (!account) {
      throw new HttpException('Cannot find account', 404);
    }

    return {
      snapshot: account.snapshot.toString('base64'),
      signature: account.signature.toString('base64') ?? '',
    };
  }
}
