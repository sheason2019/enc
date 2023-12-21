import { Injectable } from '@nestjs/common';
import { Account, Operation } from '@prisma/client';
import { prisma } from 'src/prisma/prisma';
import { IOperationDiff, IPullOperation, IPushOperation } from './typings';

@Injectable()
export class OperationService {
  async diff(
    account: Account,
    pullOperations: IPullOperation,
  ): Promise<IOperationDiff> {
    const clientIds = Object.keys(pullOperations);

    // 计算应当推送到客户端的Operation
    const pushRecords = await prisma.operation.findMany({
      where: {
        account,
        AND: {
          OR: [
            ...clientIds.map((clientId) => ({
              clientId,
              clock: { notIn: pullOperations[clientId] },
            })),
            {
              clientId: { notIn: clientIds },
            },
          ],
        },
      },
    });

    const push: IOperationDiff['push'] = [];
    for (const record of pushRecords) {
      push.push({
        clientId: record.clientId,
        clock: record.clock,
        data: record.data,
      });
    }

    // 计算应当从客户端拉取的Operation
    if (Object.keys(pullOperations).length > 0) {
      const existRecords = await prisma.operation.findMany({
        where: {
          account,
          AND: {
            OR: clientIds.map((clientId) => ({
              clientId,
              clock: { in: pullOperations[clientId] },
            })),
          },
        },
        select: {
          clientId: true,
          clock: true,
        },
      });
      for (const record of existRecords) {
        const list = pullOperations[record.clientId];
        const index = list.indexOf(record.clock);
        list.splice(index, 1);
      }
    }

    return {
      push,
      pull: pullOperations,
    };
  }

  async apply(
    account: Account,
    operations: IPushOperation[],
  ): Promise<Operation[]> {
    const operationRecords = await prisma.$transaction(async (tx) => {
      const records: Operation[] = [];
      for (const operation of operations) {
        const exist = await tx.operation.findFirst({
          where: {
            clientId: operation.clientId,
            clock: operation.clock,
            account,
          },
          select: {
            id: true,
          },
        });
        if (!!exist) continue;
        const record = await tx.operation.create({
          data: {
            clientId: operation.clientId,
            clock: operation.clock,
            data: operation.data,
            account: {
              connect: {
                id: account.id,
              },
            },
          },
        });
        records.push(record);
      }
      return records;
    });
    return operationRecords;
  }
}
