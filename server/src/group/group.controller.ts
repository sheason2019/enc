import {
  Body,
  Controller,
  Get,
  HttpException,
  Param,
  Post,
  Put,
  Query,
  UseInterceptors,
} from '@nestjs/common';
import { GroupService } from './group.service';
import { NoFilesInterceptor } from '@nestjs/platform-express';
import { sheason_chat } from 'src/prototypes';
import { CryptoService } from 'src/crypto/crypto.service';
import { AccountService } from 'src/account/account.service';
import { prisma } from 'src/prisma/prisma';
import { SubscribeGateway } from 'src/subscribe/subscribe.gateway';

@Controller('group')
export class GroupController {
  constructor(
    private readonly groupService: GroupService,
    private readonly cryptoService: CryptoService,
    private readonly accountService: AccountService,
    private readonly subscribeGateway: SubscribeGateway,
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

  @Get(':groupId/message')
  async handleGetMessages(@Param('groupId') groupId: string) {
    const messages = await prisma.message.findMany({
      where: {
        group: {
          signPubkey: groupId,
        },
      },
    });

    return messages.map((e) => e.buffer.toString('base64'));
  }

  @Post(':groupId/message')
  @UseInterceptors(NoFilesInterceptor())
  async handlePostMessages(
    @Param('groupId') groupId: string,
    @Body()
    body: {
      data: string;
    },
  ) {
    const group = await this.groupService.findGroup(groupId);
    if (!group) {
      throw new HttpException('cannot find group', 404);
    }

    const agentSecret = sheason_chat.AccountSecret.decode(group.agentSecret);
    const wrappers = (JSON.parse(body.data) as string[])
      .map((e) => Buffer.from(e, 'base64'))
      .map((e) => sheason_chat.SignWrapper.decode(e));
    const encodeWrappers: sheason_chat.SignWrapper[] = [];
    for (const wrapper of wrappers) {
      if (!this.cryptoService.verifySignature(wrapper)) {
        console.warn('verify wrapper signature failed');
        continue;
      }

      const secretBox = sheason_chat.PortableSecretBox.decode(wrapper.buffer);
      const message = sheason_chat.PortableMessage.decode(
        this.cryptoService.decrypt(agentSecret, secretBox),
      );
      encodeWrappers.push(this.groupService.encodeMessage(group, message));
    }

    if (encodeWrappers.length === 0) return;

    const conv = sheason_chat.PortableConversation.decode(
      group.portableConversation,
    );
    const accounts = await this.accountService.findIn(
      conv.members.map((e) => e.index.signPubKey),
    );
    for (const wrapper of encodeWrappers) {
      await prisma.message.create({
        data: {
          signature: Buffer.from(wrapper.sign),
          buffer: Buffer.from(
            sheason_chat.SignWrapper.encode(wrapper).finish(),
          ),
          accounts: {
            connect: accounts,
          },
          groupID: group.id,
        },
      });
    }

    this.subscribeGateway.server.to(accounts.map((e) => e.signPubkey)).emit(
      'push-message',
      encodeWrappers
        .map((e) => sheason_chat.SignWrapper.encode(e).finish())
        .map((e) => Buffer.from(e).toString('base64')),
    );
    await this.groupService.distrobuteMessage(group, encodeWrappers);
  }

  @Put(':groupId/avatar')
  @UseInterceptors(NoFilesInterceptor())
  async handlePutAvatar(
    @Param('groupId') groupId: string,
    @Body() body: { data: string },
  ) {
    const group = await this.groupService.findGroup(groupId);
    if (!group) {
      throw new HttpException('cannot find group', 404);
    }

    const wrapper = sheason_chat.SignWrapper.decode(
      Buffer.from(body.data, 'base64'),
    );
    if (!this.cryptoService.verifySignature(wrapper)) {
      throw new HttpException('verify signautre failed', 403);
    }

    const data: { groupId: string; avatarUrl: string } = JSON.parse(
      Buffer.from(wrapper.buffer).toString('utf8'),
    );
    if (data.groupId !== groupId) {
      throw new HttpException('content invalid', 400);
    }

    const conversation = sheason_chat.PortableConversation.decode(
      group.portableConversation,
    );
    if (conversation.avatarUrl === data.avatarUrl) {
      return 'OK';
    }

    conversation.avatarUrl = data.avatarUrl;
    conversation.version++;
    const newConv = Buffer.from(
      sheason_chat.PortableConversation.encode(conversation).finish(),
    );
    const updated = await prisma.group.update({
      where: {
        id: group.id,
      },
      data: {
        portableConversation: newConv,
      },
    });

    await this.groupService.emitGroupUpdate(updated);
    return 'OK';
  }

  @Put(':groupId/name')
  @UseInterceptors(NoFilesInterceptor())
  async handlePutName(
    @Param('groupId') groupId: string,
    @Body() body: { data: string },
  ) {
    const group = await this.groupService.findGroup(groupId);
    if (!group) {
      throw new HttpException('cannot find group', 404);
    }

    const wrapper = sheason_chat.SignWrapper.decode(
      Buffer.from(body.data, 'base64'),
    );
    if (!this.cryptoService.verifySignature(wrapper)) {
      throw new HttpException('verify signautre failed', 403);
    }

    console.log(Buffer.from(wrapper.buffer).toString('utf-8'));
    const data: { groupId: string; name: string } = JSON.parse(
      Buffer.from(wrapper.buffer).toString('utf-8'),
    );
    if (data.groupId !== groupId) {
      throw new HttpException('content invalid', 400);
    }

    const conversation = sheason_chat.PortableConversation.decode(
      group.portableConversation,
    );
    if (conversation.name === data.name) {
      return 'OK';
    }

    conversation.name = data.name;
    conversation.version++;
    const newConv = Buffer.from(
      sheason_chat.PortableConversation.encode(conversation).finish(),
    );
    const updated = await prisma.group.update({
      where: {
        id: group.id,
      },
      data: {
        portableConversation: newConv,
      },
    });

    await this.groupService.emitGroupUpdate(updated);
    return 'OK';
  }

  @Get(':groupId')
  async handleGetGroup(
    @Param('groupId') groupId: string,
    @Query('member') member: string,
  ) {
    const group = await this.groupService.findGroup(groupId);
    if (!group) {
      throw new HttpException('cannot find group', 404);
    }

    if (!member) {
      const conversation = this.groupService.desensitiveConversation(group);
      return Buffer.from(
        sheason_chat.PortableConversation.encode(conversation).finish(),
      ).toString('base64');
    }

    const groupMember = await prisma.groupMembers.findFirst({
      where: {
        signPubkey: member,
        groupID: group.id,
      },
    });
    if (!groupMember) {
      throw new HttpException('cannot find group member', 404);
    }

    const groupSecret = sheason_chat.AccountSecret.decode(group.agentSecret);
    const snapshot = sheason_chat.AccountSnapshot.decode(groupMember.snapshot);
    const secretBox = this.cryptoService.encrypt(
      groupSecret,
      snapshot.index,
      group.portableConversation,
    );
    const wrapper = this.cryptoService.createSignature(
      groupSecret,
      Buffer.from(sheason_chat.PortableSecretBox.encode(secretBox).finish()),
    );

    return Buffer.from(
      sheason_chat.SignWrapper.encode(wrapper).finish(),
    ).toString('base64');
  }
}
