import { SubscribeMessage, WebSocketGateway } from '@nestjs/websockets';
import { Socket } from 'socket.io';

export interface IPayload {
  socketId: string;
  account: string;
}

@WebSocketGateway({ path: '/replica' })
export class ReplicaGateway {
  @SubscribeMessage('pull')
  handlePull(client: Socket, payload: IPayload) {
    client
      .to(payload.socketId)
      .emit('pull', { ...payload, socketId: client.id });
  }

  @SubscribeMessage('push')
  handlePush(client: Socket, payload: IPayload) {
    client
      .to(payload.socketId)
      .emit('push', { ...payload, socketId: client.id });
  }

  @SubscribeMessage('verify-code')
  handleVerifyCode(client: Socket, payload: IPayload) {
    client
      .to(payload.socketId)
      .emit('verify-code', { ...payload, socketId: client.id });
  }

  @SubscribeMessage('secret')
  handleSecret(client: Socket, payload: IPayload) {
    client
      .to(payload.socketId)
      .emit('secret', { ...payload, socketId: client.id });
  }
}
