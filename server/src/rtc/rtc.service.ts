import { Injectable } from '@nestjs/common';
import { Account } from '@prisma/client';
import { IRtcModel } from './rtc.dto';
import { prisma } from 'src/prisma/prisma';

@Injectable()
export class RtcService {
  async createRtc(account: Account, model: IRtcModel) {
    return prisma.rtcRecord.create({
      data: {
        serviceUrl: model.serviceUrl,
        uuid: model.uuid,
        name: model.name,
        account: {
          connect: account,
        },
      },
    });
  }

  findRtc(account: Account, uuid: string) {
    return prisma.rtcRecord.findFirst({
      where: {
        account,
        uuid,
      },
    });
  }
}
