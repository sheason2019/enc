import { Injectable } from '@nestjs/common';
import { sheason_chat } from 'prototypes';
import { Account } from '@prisma/client';
import { prisma } from 'src/prisma/prisma';

@Injectable()
export class AccountService {
  async put(snapshot: sheason_chat.AccountSnapshot): Promise<Account> {
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
        if (existSnapshot.createdAt >= snapshot.createdAt) {
          return exist;
        }

        exist.snapshot = Buffer.from(
          sheason_chat.AccountSnapshot.encode(snapshot).finish(),
        );
        await tx.account.update({
          where: {
            id: exist.id,
          },
          data: {
            snapshot: exist.snapshot,
          },
        });
        return exist;
      }

      return tx.account.create({
        data: {
          signPubkey: snapshot.index.signPubKey,
          ecdhPubkey: snapshot.index.ecdhPubKey,
          snapshot: Buffer.from(
            sheason_chat.AccountSnapshot.encode(snapshot).finish(),
          ),
        },
      });
    });
  }
}
