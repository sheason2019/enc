import { Injectable } from '@nestjs/common';
import { Account, Group } from '@prisma/client';
import axios from 'axios';
import { randomUUID } from 'crypto';
import { AccountService } from 'src/account/account.service';
import { CryptoService } from 'src/crypto/crypto.service';
import { prisma } from 'src/prisma/prisma';
import { sheason_chat } from 'src/prototypes';

@Injectable()
export class GroupService {
  constructor(
    private readonly cryptoService: CryptoService,
    private readonly accountService: AccountService,
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

    const portable = sheason_chat.PortableConversation.create({
      type: sheason_chat.ConversationType.CONVERSATION_GROUP,
      members: conversation.members,
      owner: sheason_chat.AccountSnapshot.decode(account.snapshot),
      remoteUrl: conversation.remoteUrl,
      agent: groupAgent,
      version: 1,
      declaredSecrets: [this.cryptoService.generateSecret()],
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
        groupMembers: {
          create: conversation.members.map((e) => ({
            signPubkey: e.index.signPubKey,
            snapshot: Buffer.from(
              sheason_chat.AccountSnapshot.encode(e).finish(),
            ),
          })),
        },
      },
    });
    const desenConv = this.desensitiveConversation(group);

    const initialMessageWrappers: sheason_chat.SignWrapper[] = [];
    const createMessage = sheason_chat.PortableMessage.create({
      conversation: desenConv,
      messageType: sheason_chat.MessageType.MESSAGE_TYPE_NOTIFY,
      content: JSON.stringify({
        type: 'create',
        payload: account.signPubkey,
      }),
      uuid: randomUUID(),
      createdAt: new Date().getTime(),
    });
    initialMessageWrappers.push(this.encodeMessage(group, createMessage));
    if (conversation.members.length > 1) {
      const inviteMessage = sheason_chat.PortableMessage.create({
        conversation: desenConv,
        messageType: sheason_chat.MessageType.MESSAGE_TYPE_NOTIFY,
        content: JSON.stringify({
          type: 'invite',
          payload: {
            operator: account.signPubkey,
            members: conversation.members
              .filter((e) => e.index.signPubKey !== account.signPubkey)
              .map((e) => e.index.signPubKey),
          },
        }),
        uuid: randomUUID(),
        createdAt: new Date().getTime(),
      });
      initialMessageWrappers.push(this.encodeMessage(group, inviteMessage));
    }

    const accounts = await this.accountService.findIn(
      conversation.members.map((e) => e.index.signPubKey),
    );

    for (const wrapper of initialMessageWrappers) {
      await prisma.message.create({
        data: {
          signature: Buffer.from(wrapper.sign),
          buffer: Buffer.from(
            sheason_chat.SignWrapper.encode(wrapper).finish(),
          ),
          accounts: {
            connect: accounts,
          },
          group: {
            connect: {
              id: group.id,
            },
          },
        },
      });
    }

    await this.emitGroupUpdate(group);
    await this.distrobuteMessage(group, initialMessageWrappers);

    return group;
  }

  encodeMessage(
    group: Group,
    message: sheason_chat.IPortableMessage,
  ): sheason_chat.SignWrapper {
    const agentSecret = sheason_chat.AccountSecret.decode(group.agentSecret);
    const conversation = sheason_chat.PortableConversation.decode(
      group.portableConversation,
    );
    const secrets = conversation.declaredSecrets;
    const key = secrets[secrets.length - 1];
    const secretBox = this.cryptoService.secretEncrypt(
      Buffer.from(key),
      Buffer.from(sheason_chat.PortableMessage.encode(message).finish()),
    );
    secretBox.sender = {
      signPubKey: agentSecret.signPubKey,
      ecdhPubKey: agentSecret.ecdhPubKey,
    };
    secretBox.receiver = secretBox.sender;
    const buffer = Buffer.from(
      sheason_chat.PortableSecretBox.encode(secretBox).finish(),
    );
    const wrapper = this.cryptoService.createSignature(agentSecret, buffer);
    wrapper.encrypt = true;
    wrapper.contentType = sheason_chat.ContentType.CONTENT_MESSAGE;
    return wrapper;
  }

  async distrobuteMessage(group: Group, wrappers: sheason_chat.SignWrapper[]) {
    const members = await prisma.groupMembers.findMany({
      where: {
        groupID: group.id,
      },
    });
    const urlSet = new Set<string>();
    for (const member of members) {
      const snapshot = sheason_chat.AccountSnapshot.decode(member.snapshot);
      for (const url of Object.keys(snapshot.serviceMap)) {
        urlSet.add(url);
      }
    }

    const formData = new FormData();
    formData.append(
      'data',
      JSON.stringify(
        wrappers
          .map((e) => sheason_chat.SignWrapper.encode(e).finish())
          .map((e) => Buffer.from(e).toString('base64')),
      ),
    );
    formData.append(
      'receivers',
      JSON.stringify(members.map((e) => e.signPubkey)),
    );

    for (const url of urlSet) {
      axios
        .postForm(`${url}/message`, formData)
        .catch((e) => console.log('[WARN] distrobute message failed', e));
    }
  }

  // 通知相关用户群组信息已更新
  async emitGroupUpdate(group: Group) {
    const agentSecret = sheason_chat.AccountSecret.decode(group.agentSecret);
    const members = await prisma.groupMembers.findMany({
      where: {
        groupID: group.id,
      },
    });

    for (const member of members) {
      const snapshot = sheason_chat.AccountSnapshot.decode(member.snapshot);
      const secretBox = this.cryptoService.encrypt(
        agentSecret,
        snapshot.index,
        group.portableConversation,
      );
      const wrapper = this.cryptoService.createSignature(
        agentSecret,
        Buffer.from(sheason_chat.PortableSecretBox.encode(secretBox).finish()),
      );
      wrapper.contentType = sheason_chat.ContentType.CONTENT_CONVERSATION;
      wrapper.encrypt = true;

      const formData = new FormData();
      formData.append(
        'data',
        JSON.stringify([
          Buffer.from(
            sheason_chat.SignWrapper.encode(wrapper).finish(),
          ).toString('base64'),
        ]),
      );
      formData.append('receivers', JSON.stringify([member.signPubkey]));

      for (const url of Object.keys(snapshot.serviceMap)) {
        axios.postForm(`${url}/message`, formData);
      }
    }
  }

  desensitiveConversation(group: Group) {
    const conversation = sheason_chat.PortableConversation.decode(
      group.portableConversation,
    );

    conversation.declaredSecrets = [];
    conversation.owner = null;
    conversation.members = [];
    return conversation;
  }
}
