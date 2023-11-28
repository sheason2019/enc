import { SubscribeMessage, WebSocketGateway } from '@nestjs/websockets';
import { Socket } from 'socket.io';
import { Account } from '@prisma/client';
import { AccountService } from 'src/account/account.service';
import { OperationService } from 'src/operation/operation.service';
import { sheason_chat } from 'prototypes';
import { IPullOperation, IPushOperation } from 'src/operation/typings';

@WebSocketGateway({ path: '/subscribe' })
export class SubscribeGateway {
  constructor(
    private readonly accountService: AccountService,
    private readonly operationService: OperationService,
  ) {}

  socketMap = new WeakMap<Socket, Account>();

  @SubscribeMessage('subscribe')
  async handleSubscribe(
    client: Socket,
    payload: { deviceId: string; snapshot: string },
  ) {
    const snapshot = sheason_chat.AccountSnapshot.decode(
      Buffer.from(payload.snapshot, 'base64'),
    );
    await client.join(snapshot.index.signPubKey);
    const account = await this.accountService.put(snapshot);
    this.socketMap.set(client, account);
    return true;
  }

  @SubscribeMessage('sync-operation')
  async handleSyncOperation(client: Socket, payload: IPullOperation) {
    const account = this.socketMap.get(client);
    if (!account) {
      throw new Error('Cannot find account by socket client');
    }

    const diffMap = await this.operationService.diff(account, payload);
    console.log('account id', account.id, 'diff map::', diffMap);
    if (diffMap.push.length > 0) {
      client.emit('push-operation', { operations: diffMap.push });
    }
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
    console.log(
      'account id',
      account.id,
      'push-operations',
      payload.operations,
    );
    await this.operationService.apply(account, payload.operations);
  }
}
