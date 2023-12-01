import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { sheason_chat } from './prototypes';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getService(): string {
    const service = this.appService.getService();
    return Buffer.from(
      sheason_chat.PortableService.encode(service).finish(),
    ).toString('base64');
  }
}
