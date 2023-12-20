import {
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import { Socket, Server } from 'socket.io';
import { CryptoService } from 'src/crypto/crypto.service';
import { sheason_chat } from 'src/prototypes';
import { RtcService } from './rtc.service';

@WebSocketGateway({ path: '/rtc.io' })
export class RtcGateway {
  constructor(
    private readonly cryptoService: CryptoService,
    private readonly rtcService: RtcService,
  ) {}

  @WebSocketServer()
  server: Server;

  clientMap = new Map<string, string>();

  @SubscribeMessage('join')
  async handleMessage(client: Socket, payload: { wrapper: string }) {
    const wrapper = sheason_chat.SignWrapper.decode(
      Buffer.from(payload.wrapper, 'base64'),
    );
    const valid = this.cryptoService.verifySignature(wrapper);
    if (!valid) {
      throw new Error('verify signature failed');
    }

    const joinData: { snapshot: string; uuid: string } = JSON.parse(
      Buffer.from(wrapper.buffer).toString('utf-8'),
    );
    const rtcRecord = await this.rtcService.findRtc(joinData.uuid);
    if (!rtcRecord) {
      throw new Error('cannot find current rtc');
    }

    const snapshot = sheason_chat.AccountSnapshot.decode(
      Buffer.from(joinData.snapshot, 'base64'),
    );

    client.join(joinData.uuid);
    this.clientMap.set(client.id, payload.wrapper);
    const roomSockets = await this.server.sockets
      .in(joinData.uuid)
      .fetchSockets();

    const members: { clientId: string; wrapper: string }[] = [];
    for (const socket of roomSockets) {
      if (socket.id === client.id) continue;

      const wrapper = this.clientMap.get(socket.id);
      members.push({
        clientId: socket.id,
        wrapper,
      });
    }

    client.emit('members', {
      members,
    });

    client.broadcast.to(joinData.uuid).emit('join', {
      wrapper: payload.wrapper,
      clientId: client.id,
    });

    return snapshot.index.signPubKey;
  }

  @SubscribeMessage('exchange')
  async handleExchange(client: Socket, payload: { clientId: string }) {
    client
      .to(payload.clientId)
      .emit('exchange', { ...payload, clientId: client.id });
  }

  handleDisconnect(client: Socket) {
    const wrapper = sheason_chat.SignWrapper.decode(
      Buffer.from(this.clientMap.get(client.id), 'base64'),
    );
    if (!wrapper) return;

    this.clientMap.delete(client.id);
    const joinData: { snapshot: string; uuid: string } = JSON.parse(
      Buffer.from(wrapper.buffer).toString('utf-8'),
    );
    this.server.to(joinData.uuid).emit('leave', {
      clientId: client.id,
    });
  }
}
