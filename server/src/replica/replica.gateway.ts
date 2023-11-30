import {
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import { Socket, Server } from 'socket.io';
import { ReplicaService } from './replica.service';

export interface IPayload {
  socketId: string;
  account: string;
}

@WebSocketGateway({ path: '/replica' })
export class ReplicaGateway {
  constructor(private readonly replicaService: ReplicaService) {}

  @WebSocketServer()
  server: Server;

  // namespace 创建者 WeakMap 在用户断开连接后 Dispose Namespace
  nsCreatorMap = new WeakMap<Socket, string>();
  // 被占用的 Namespace，避免发生冲突
  nsConnectMap = new Map<string, Socket | null>();
  // Socket 与 namespace 的绑定
  nsBindMap = new WeakMap<Socket, string>();

  @SubscribeMessage('create-namespace')
  handleCreateNamespace(client: Socket) {
    // 单一用户在一个连接生命周期内只能占用一个 NameSpace
    if (this.nsCreatorMap.has(client)) {
      return client.emit(
        'error',
        'Current connection already regist a namespace',
      );
    }

    let ns: string | null = null;
    for (let i = 0; i < 5; i++) {
      const create = this.replicaService.generateNamespace();
      if (this.nsConnectMap.has(create)) {
        continue;
      }
      ns = create;
      break;
    }

    if (ns === null) {
      return client.emit('error', 'Failed to generate a random namespace');
    }

    this.nsCreatorMap.set(client, ns);
    this.nsConnectMap.set(ns, null);
    this.nsBindMap.set(client, ns);
    client.join(ns);

    client.emit('namespace', ns);
  }

  @SubscribeMessage('join-namespace')
  handleJoinNamespace(
    client: Socket,
    payload: { namespace: string; account: string },
  ) {
    const ns = payload.namespace.toUpperCase();
    if (!this.nsConnectMap.has(ns)) {
      return client.emit('error', 'cannot find namespace ' + ns);
    }
    if (this.nsConnectMap.get(ns) !== null) {
      return client.emit('error', 'current namespace already consumed');
    }
    client.join(ns);
    this.nsConnectMap.set(ns, client);
    this.nsBindMap.set(client, ns);
    client.broadcast
      .to(ns)
      .emit('join-namespace', { ...payload, namespace: ns });
  }

  @SubscribeMessage('exchange')
  handleExchange(client: Socket, payload: object) {
    const ns = this.nsBindMap.get(client);
    if (!ns) {
      return client.emit(
        'error',
        'cannot find namespace by current connection',
      );
    }

    client.broadcast.to(ns).emit('exchange', payload);
  }

  handleDisconnect(client: Socket) {
    const ns = this.nsCreatorMap.get(client);
    this.nsCreatorMap.delete(client);
    this.nsConnectMap.delete(ns);
  }
}
