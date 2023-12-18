import {
  Body,
  Controller,
  HttpException,
  Post,
  UseInterceptors,
} from '@nestjs/common';
import { GroupService } from './group.service';
import { NoFilesInterceptor } from '@nestjs/platform-express';
import { sheason_chat } from 'src/prototypes';
import { CryptoService } from 'src/crypto/crypto.service';
import { AccountService } from 'src/account/account.service';

@Controller('group')
export class GroupController {
  constructor(
    private readonly groupService: GroupService,
    private readonly cryptoService: CryptoService,
    private readonly accountService: AccountService,
  ) {}

  @Post()
  @UseInterceptors(NoFilesInterceptor())
  async handlePost(@Body() body: { data: string }) {
    const wrapper = sheason_chat.SignWrapper.decode(
      Buffer.from(body.data, 'base64'),
    );
    if (!this.cryptoService.verifySignature(wrapper)) {
      throw new HttpException('verify signature error', 403);
    }

    const account = await this.accountService.find(wrapper.signer.signPubKey);
    if (!account) {
      throw new HttpException('cannot find account', 404);
    }
    const snapshot = sheason_chat.AccountSnapshot.decode(account.snapshot);

    const conversation = sheason_chat.PortableConversation.decode(
      wrapper.buffer,
    );

    const group = await this.groupService.createGroup(account, conversation);
    const groupSecret = sheason_chat.AccountSecret.decode(group.agentSecret);
    const secretBox = this.cryptoService.encrypt(
      groupSecret,
      snapshot.index,
      group.portableConversation,
    );
    const respWrapper = this.cryptoService.createSignature(
      groupSecret,
      Buffer.from(sheason_chat.PortableSecretBox.encode(secretBox).finish()),
    );
    respWrapper.encrypt = true;

    return Buffer.from(
      sheason_chat.SignWrapper.encode(respWrapper).finish(),
    ).toString('base64');
  }
}
