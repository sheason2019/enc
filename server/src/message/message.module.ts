import { Module } from '@nestjs/common';
import { MessageService } from './message.service';
import { MessageController } from './message.controller';
import { AccountModule } from 'src/account/account.module';

@Module({
  providers: [MessageService],
  controllers: [MessageController],
  imports: [AccountModule],
})
export class MessageModule {}
