import { Module } from '@nestjs/common';
import { GroupService } from './group.service';
import { GroupController } from './group.controller';
import { AccountModule } from 'src/account/account.module';
import { CryptoModule } from 'src/crypto/crypto.module';

@Module({
  providers: [GroupService],
  controllers: [GroupController],
  imports: [AccountModule, CryptoModule],
})
export class GroupModule {}
