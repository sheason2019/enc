import {
  Body,
  Controller,
  HttpException,
  Param,
  Post,
  UseInterceptors,
} from '@nestjs/common';
import { NoFilesInterceptor } from '@nestjs/platform-express';
import { AccountService } from 'src/account/account.service';
import { sheason_chat } from 'src/prototypes';
import { MessageService } from './message.service';
import { SubscribeGateway } from 'src/subscribe/subscribe.gateway';

@Controller()
export class MessageController {
  constructor(
    private readonly accountService: AccountService,
    private readonly messageService: MessageService,
    private readonly subscribeGateway: SubscribeGateway,
  ) {}

  @Post(':signPubkey/messages')
  @UseInterceptors(NoFilesInterceptor())
  async handleMessage(
    @Body() body: { data: string },
    @Param('signPubkey') signPubkey: string,
  ) {
    const account = await this.accountService.find(signPubkey);
    if (!account) {
      throw new HttpException('cannot find account', 404);
    }
    const wrapper = sheason_chat.SignWrapper.decode(
      Buffer.from(body.data, 'base64'),
    );
    await this.messageService.put(account, wrapper);

    this.subscribeGateway.server
      .to(account.signPubkey)
      .emit('push-message', { messages: [body.data] });

    return 'OK';
  }
}
