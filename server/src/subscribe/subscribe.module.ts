import { Module } from '@nestjs/common';
import { SubscribeGateway } from './subscribe.gateway';
import { AccountModule } from 'src/account/account.module';
import { OperationModule } from 'src/operation/operation.module';

@Module({
  providers: [SubscribeGateway],
  imports: [AccountModule, OperationModule],
})
export class SubscribeModule {}
