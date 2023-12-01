import { Module } from '@nestjs/common';
import { AccountService } from './account.service';
import { AccountController } from './account.controller';
import { CryptoModule } from 'src/crypto/crypto.module';

@Module({
  providers: [AccountService],
  exports: [AccountService],
  controllers: [AccountController],
  imports: [CryptoModule],
})
export class AccountModule {}
