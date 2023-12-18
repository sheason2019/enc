import {
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import { Socket, Server } from 'socket.io';
import { Account } from '@prisma/client';
import { AccountService } from 'src/account/account.service';
import { OperationService } from 'src/operation/operation.service';
import { sheason_chat } from 'src/prototypes';
import { IPullOperation, IPushOperation } from 'src/operation/typings';
import { prisma } from 'src/prisma/prisma';

@WebSocketGateway({ path: '/subscribe' })
export class SubscribeGateway {
  constructor(
    private readonly accountService: AccountService,
    private readonly operationService: OperationService,
  ) {}

  socketMap = new WeakMap<Socket, Account>();

  @WebSocketServer()
  server: Server;

  @SubscribeMessage('subscribe')
  async handleSubscribe(
    client: Socket,
    payload: { deviceId: string; snapshot: string },
  ) {
    const snapshot = sheason_chat.AccountSnapshot.decode(
      Buffer.from(payload.snapshot, 'base64'),
    );
    // 检查账号是否存在，若不存在则 emit pull-snapshot 事件
    const account = await this.accountService.find(snapshot.index.signPubKey);
    if (!account) {
      client.emit('pull-snapshot');
      return;
    }

    await client.join(account.signPubkey);
    this.socketMap.set(client, account);
    client.emit('sync-operation');

    return snapshot.index.signPubKey;
  }

  @SubscribeMessage('sync-operation')
  async handleSyncOperation(client: Socket, payload: IPullOperation) {
    const account = this.socketMap.get(client);
    if (!account) {
      throw new Error('Cannot find account by socket client');
    }

    const diffMap = await this.operationService.diff(account, payload);

    client.emit('push-operation', { operations: diffMap.push });
    if (Object.keys(diffMap.pull).length > 0) {
      client.emit('pull-operation', diffMap.pull);
    }
  }

  @SubscribeMessage('push-operation')
  async handlePushOperation(
    client: Socket,
    payload: { operations: IPushOperation[] },
  ) {
    const account = this.socketMap.get(client);
    if (!account) {
      throw new Error('Cannot find account by socket client');
    }

    const applyList = await this.operationService.apply(
      account,
      payload.operations,
    );
    if (applyList.length > 0) {
      client.broadcast.to(account.signPubkey).emit('sync-operation');
    }
  }

  @SubscribeMessage('sync-message')
  async handleSyncMessage(client: Socket, payload: { signatures: string[] }) {
    const account = this.socketMap.get(client);
    if (!account) {
      throw new Error('Cannot find account by socket client');
    }

    const records = await prisma.message.findMany({
      where: {
        Account: {
          some: {
            id: account.id,
          },
        },
        signature: {
          notIn: payload.signatures.map((e) => Buffer.from(e, 'base64')),
        },
      },
    });

    client.emit('push-message', {
      messages: JSON.stringify(records.map((e) => e.buffer.toString('base64'))),
    });
  }
}
