import { Injectable } from '@nestjs/common';
import { Account, Message } from '@prisma/client';
import { prisma } from 'src/prisma/prisma';
import { sheason_chat } from 'src/prototypes';

@Injectable()
export class MessageService {
  async put(
    accounts: Account[],
    data: sheason_chat.SignWrapper,
  ): Promise<Message | undefined> {
    return prisma.$transaction(async (tx) => {
      const exist = await tx.message.findFirst({
        where: {
          signature: Buffer.from(data.sign),
        },
      });
      if (!!exist) return exist;
      return tx.message.create({
        data: {
          signature: Buffer.from(data.sign),
          buffer: Buffer.from(sheason_chat.SignWrapper.encode(data).finish()),
          accounts: {
            connect: accounts,
          },
        },
      });
    });
  }
}
