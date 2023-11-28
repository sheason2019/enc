import { Injectable } from '@nestjs/common';
import { sheason_chat } from 'prototypes';

@Injectable()
export class AppService {
  getService(): sheason_chat.PortableService {
    return sheason_chat.PortableService.create({});
  }
}
