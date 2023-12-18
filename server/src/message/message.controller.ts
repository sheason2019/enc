import {
  Body,
  Controller,
  HttpException,
  Post,
  UseInterceptors,
} from '@nestjs/common';
import { NoFilesInterceptor } from '@nestjs/platform-express';
import { AccountService } from 'src/account/account.service';
import { sheason_chat } from 'src/prototypes';
import { MessageService } from './message.service';
import { SubscribeGateway } from 'src/subscribe/subscribe.gateway';
import { CryptoService } from 'src/crypto/crypto.service';

@Controller('message')
export class MessageController {
  constructor(
    private readonly accountService: AccountService,
    private readonly messageService: MessageService,
    private readonly cryptoService: CryptoService,
    private readonly subscribeGateway: SubscribeGateway,
  ) {}

  @Post()
  @UseInterceptors(NoFilesInterceptor())
  async handleMessage(@Body() body: { data: string; receivers: string }) {
    const receivers: string[] = JSON.parse(body.receivers);
    const accounts = await this.accountService.findIn(receivers);
    if (accounts.length === 0) {
      throw new HttpException('cannot find account', 404);
    }

    const data: string[] = JSON.parse(body.data);
    const wrappers = data.map((e) =>
      sheason_chat.SignWrapper.decode(Buffer.from(e, 'base64')),
    );
    for (const wrapper of wrappers) {
      if (this.cryptoService.verifySignature(wrapper)) {
        await this.messageService.put(accounts, wrapper);
      }
    }

    this.subscribeGateway.server
      .to(accounts.map((e) => e.signPubkey))
      .emit('push-message', { messages: body.data });

    return 'OK';
  }
}
