import { Injectable } from '@nestjs/common';
import { Account, Group } from '@prisma/client';
import { CryptoService } from 'src/crypto/crypto.service';
import { prisma } from 'src/prisma/prisma';
import { sheason_chat } from 'src/prototypes';

@Injectable()
export class GroupService {
  constructor(private readonly cryptoService: CryptoService) {}

  async createGroup(
    account: Account,
    conversation: sheason_chat.PortableConversation,
  ): Promise<Group> {
    const secret = this.cryptoService.generate();

    const portable = sheason_chat.PortableConversation.create({
      type: sheason_chat.ConversationType.CONVERSATION_GROUP,
      members: conversation.members,
      owner: sheason_chat.AccountSnapshot.decode(account.snapshot),
      remoteUrl: conversation.remoteUrl,
      agent: {
        signPubKey: secret.signPubKey,
        ecdhPubKey: secret.ecdhPubKey,
      },
      version: 0,
    });

    return prisma.group.create({
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
        GroupMembers: {
          create: conversation.members.map((e) => ({
            signPubkey: e.index.signPubKey,
            snapshot: Buffer.from(
              sheason_chat.AccountSnapshot.encode(e).finish(),
            ),
          })),
        },
      },
    });
  }
}
