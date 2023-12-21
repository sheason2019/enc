import { Injectable } from '@nestjs/common';
import { Account, Group } from '@prisma/client';
import { AccountService } from 'src/account/account.service';
import { CryptoService } from 'src/crypto/crypto.service';
import { prisma } from 'src/prisma/prisma';
import { sheason_chat } from 'src/prototypes';
import { GroupMessageFactory } from './message/message.factory';
import { GroupMessageService } from './message/message.service';

@Injectable()
export class GroupService {
  constructor(
    private readonly cryptoService: CryptoService,
    private readonly accountService: AccountService,
    private readonly groupMessageFactory: GroupMessageFactory,
    private readonly groupMessageService: GroupMessageService,
  ) {}

  findGroup(groupId: string) {
    return prisma.group.findFirst({
      where: {
        signPubkey: groupId,
      },
    });
  }

  async createGroup(
    account: Account,
    conversation: sheason_chat.PortableConversation,
  ): Promise<Group> {
    const secret = this.cryptoService.generate();
    const groupAgent = {
      signPubKey: secret.signPubKey,
      ecdhPubKey: secret.ecdhPubKey,
    };
    const operator = sheason_chat.AccountSnapshot.decode(account.snapshot);

    const portable = sheason_chat.PortableConversation.create({
      type: sheason_chat.ConversationType.CONVERSATION_GROUP,
      members: conversation.members,
      owner: sheason_chat.AccountSnapshot.decode(account.snapshot),
      remoteUrl: conversation.remoteUrl,
      agent: groupAgent,
      version: 1,
      declaredSecrets: [this.cryptoService.generateSecret()],
      name: `Group-${groupAgent.signPubKey}`,
      avatarUrl: '',
    });

    const group = await prisma.group.create({
      data: {
        account: {
          connect: account,
        },
        agentSecret: Buffer.from(
          sheason_chat.AccountSecret.encode(secret).finish(),
        ),
        portableConversation: Buffer.from(
          sheason_chat.PortableConversation.encode(portable).finish(),
        ),
        signPubkey: secret.signPubKey,
      },
    });

    const initialMessageWrappers: sheason_chat.SignWrapper[] = [];
    const createMessage = this.groupMessageFactory.create(portable, operator);
    initialMessageWrappers.push(
      this.groupMessageService.encodeMessage(group, createMessage),
    );
    if (portable.members.length > 1) {
      const inviteMessage = this.groupMessageFactory.invite(
        portable,
        operator,
        portable.members.filter(
          (e) => e.index.signPubKey !== operator.index.signPubKey,
        ),
      );
      inviteMessage.createdAt = new Date().getTime() + 1000;
      initialMessageWrappers.push(
        this.groupMessageService.encodeMessage(group, inviteMessage),
      );
    }

    await this.groupMessageService.emitGroupUpdate(group);
    await this.groupMessageService.distrobuteMessage(
      group,
      initialMessageWrappers,
    );

    return group;
  }

  async applyMembers(
    group: Group,
    operator: sheason_chat.IAccountSnapshot,
    members: sheason_chat.IAccountSnapshot[],
  ) {
    const conversation = sheason_chat.PortableConversation.decode(
      group.portableConversation,
    );

    const oldMembers = conversation.members;
    const newMembers = members;

    const removeMap = new Map<string, sheason_chat.IAccountSnapshot>();
    for (const member of oldMembers) {
      removeMap.set(member.index.signPubKey, member);
    }
    for (const member of newMembers) {
      removeMap.delete(member.index.signPubKey);
    }

    const removedMember = [...removeMap.values()];

    const inviteMap = new Map<string, sheason_chat.IAccountSnapshot>();
    for (const member of newMembers) {
      inviteMap.set(member.index.signPubKey, member);
    }
    for (const member of oldMembers) {
      inviteMap.delete(member.index.signPubKey);
    }
    const invitedMember = [...inviteMap.values()];

    if (removedMember.length > 0) {
      // 发送移除成员信息
      const removeMemberMessage = this.groupMessageFactory.remove(
        conversation,
        operator,
        removedMember,
      );
      await this.groupMessageService.distrobuteMessage(group, [
        this.groupMessageService.encodeMessage(group, removeMemberMessage),
      ]);
      // 发送会话更新通知
      conversation.members = members;
      conversation.version++;
      group.portableConversation = Buffer.from(
        sheason_chat.PortableConversation.encode(conversation).finish(),
      );
      await this.groupMessageService.emitGroupUpdate(group, removedMember);

      // 创建新的密钥
      conversation.declaredSecrets.push(this.cryptoService.generateSecret());
    }

    conversation.members = members;
    conversation.version++;
    group.portableConversation = Buffer.from(
      sheason_chat.PortableConversation.encode(conversation).finish(),
    );
    await this.groupMessageService.emitGroupUpdate(group);

    if (invitedMember.length > 0) {
      const inviteMemberMessage = this.groupMessageFactory.invite(
        conversation,
        operator,
        invitedMember,
      );
      await this.groupMessageService.distrobuteMessage(group, [
        this.groupMessageService.encodeMessage(group, inviteMemberMessage),
      ]);
    }

    return prisma.group.update({
      where: {
        id: group.id,
      },
      data: {
        portableConversation: group.portableConversation,
      },
    });
  }
}
