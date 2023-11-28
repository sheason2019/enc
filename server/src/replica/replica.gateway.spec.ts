import { Test, TestingModule } from '@nestjs/testing';
import { ReplicaGateway } from './replica.gateway';

describe('ReplicaGateway', () => {
  let gateway: ReplicaGateway;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [ReplicaGateway],
    }).compile();

    gateway = module.get<ReplicaGateway>(ReplicaGateway);
  });

  it('should be defined', () => {
    expect(gateway).toBeDefined();
  });
});
