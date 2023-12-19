import { WebSocketGateway, WebSocketServer } from '@nestjs/websockets';
import { Socket, Server } from 'socket.io';
import { IServerResource, ResourceService } from './resource.service';
import * as fs from 'fs';
import { DATA_ROOT } from 'src/env/env';

@WebSocketGateway({ path: '/resource.io' })
export class ResourceGateway {
  serverResource: IServerResource;

  constructor(private readonly resourceService: ResourceService) {
    this.initialStream();
  }

  initialStream() {
    if (!fs.existsSync(DATA_ROOT)) {
      fs.mkdirSync(DATA_ROOT, { recursive: true });
    }
    setInterval(async () => {
      const serverResource = await this.resourceService.getServerResource();
      this.server.emit('server-resource', serverResource);
      this.serverResource = serverResource;
    }, 2000);
  }

  handleConnection(client: Socket) {
    if (this.serverResource) {
      client.emit('server-resource', this.serverResource);
    }
  }

  @WebSocketServer()
  server: Server;
}
