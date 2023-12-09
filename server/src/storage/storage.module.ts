import { Module } from '@nestjs/common';
import { StorageService } from './storage.service';
import { StorageController } from './storage.controller';
import { AccountModule } from 'src/account/account.module';
import { CryptoModule } from 'src/crypto/crypto.module';

@Module({
  controllers: [StorageController],
  providers: [StorageService],
  imports: [AccountModule, CryptoModule],
})
export class StorageModule {}
