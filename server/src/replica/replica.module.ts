import { Module } from '@nestjs/common';
import { ReplicaGateway } from './replica.gateway';

@Module({
  providers: [ReplicaGateway]
})
export class ReplicaModule {}
