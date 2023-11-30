import { Module } from '@nestjs/common';
import { ReplicaGateway } from './replica.gateway';
import { ReplicaService } from './replica.service';

@Module({
  providers: [ReplicaGateway, ReplicaService]
})
export class ReplicaModule {}
