import { Module } from '@nestjs/common';
import { GroupMessageFactory } from './message.factory';
import { GroupMessageService } from './message.service';
import { CryptoModule } from 'src/crypto/crypto.module';

@Module({
  providers: [GroupMessageFactory, GroupMessageService],
  exports: [GroupMessageFactory, GroupMessageService],
  imports: [CryptoModule],
})
export class GroupMessageModule {}
