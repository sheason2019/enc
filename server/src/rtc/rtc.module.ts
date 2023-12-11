import { Module } from '@nestjs/common';
import { RtcService } from './rtc.service';
import { RtcController } from './rtc.controller';
import { RtcGateway } from './rtc.gateway';
import { AccountModule } from 'src/account/account.module';
import { CryptoModule } from 'src/crypto/crypto.module';

@Module({
  providers: [RtcService, RtcGateway],
  controllers: [RtcController],
  imports: [AccountModule, CryptoModule],
})
export class RtcModule {}
