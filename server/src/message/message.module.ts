import { Module } from '@nestjs/common';
import { MessageService } from './message.service';
import { MessageController } from './message.controller';
import { AccountModule } from 'src/account/account.module';
import { SubscribeModule } from 'src/subscribe/subscribe.module';

@Module({
  providers: [MessageService],
  controllers: [MessageController],
  imports: [AccountModule, SubscribeModule],
})
export class MessageModule {}
