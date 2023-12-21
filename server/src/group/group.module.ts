import { Module } from '@nestjs/common';
import { GroupService } from './group.service';
import { GroupController } from './group.controller';
import { AccountModule } from 'src/account/account.module';
import { CryptoModule } from 'src/crypto/crypto.module';
import { SubscribeModule } from 'src/subscribe/subscribe.module';
import { GroupMessageModule } from './message/message.module';

@Module({
  providers: [GroupService],
  controllers: [GroupController],
  imports: [AccountModule, CryptoModule, SubscribeModule, GroupMessageModule],
})
export class GroupModule {}
