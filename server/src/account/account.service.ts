import { Injectable } from '@nestjs/common';
import { sheason_chat } from 'src/prototypes';
import { Account } from '@prisma/client';
import { prisma } from 'src/prisma/prisma';

@Injectable()
export class AccountService {
  async put(
    snapshot: sheason_chat.AccountSnapshot,
    buffer: Buffer,
    signature: Buffer,
  ): Promise<Account> {
    return prisma.$transaction(async (tx) => {
      const exist = await tx.account.findFirst({
        where: {
          signPubkey: snapshot.index.signPubKey,
        },
      });
      if (!!exist) {
        const existSnapshot = sheason_chat.AccountSnapshot.decode(
          exist.snapshot,
        );

        if (existSnapshot.version >= snapshot.version) {
          return exist;
        }

        exist.snapshot = buffer;
        await tx.account.update({
          where: {
            id: exist.id,
          },
          data: {
            snapshot: buffer,
            signature,
          },
        });
        return exist;
      }

      return tx.account.create({
        data: {
          signPubkey: snapshot.index.signPubKey,
          ecdhPubkey: snapshot.index.ecdhPubKey,
          snapshot: buffer,
          signature,
        },
      });
    });
  }
  async find(signPubkey: string): Promise<Account | undefined> {
    return prisma.account.findFirst({
      where: {
        signPubkey,
      },
    });
  }

  async findIn(checker: string[]): Promise<Account[]> {
    return prisma.account.findMany({
      where: {
        signPubkey: {
          in: checker,
        },
      },
    });
  }
}
