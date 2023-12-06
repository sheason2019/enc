import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { SubscribeModule } from './subscribe/subscribe.module';
import { ReplicaModule } from './replica/replica.module';
import { AccountModule } from './account/account.module';
import { OperationModule } from './operation/operation.module';
import { CryptoModule } from './crypto/crypto.module';
import { MessageModule } from './message/message.module';

@Module({
  imports: [
    SubscribeModule,
    ReplicaModule,
    AccountModule,
    OperationModule,
    CryptoModule,
    MessageModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
