import { Module } from '@nestjs/common';
import { ResourceController } from './resource.controller';
import { ResourceService } from './resource.service';
import { ResourceGateway } from './resource.gateway';
import { SubscribeModule } from 'src/subscribe/subscribe.module';
import { AccountModule } from 'src/account/account.module';

@Module({
  controllers: [ResourceController],
  providers: [ResourceService, ResourceGateway],
  imports: [SubscribeModule, AccountModule],
})
export class ResourceModule {}
