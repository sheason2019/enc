import { Test, TestingModule } from '@nestjs/testing';
import { SubscribeGateway } from './subscribe.gateway';

describe('SubscribeGateway', () => {
  let gateway: SubscribeGateway;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [SubscribeGateway],
    }).compile();

    gateway = module.get<SubscribeGateway>(SubscribeGateway);
  });

  it('should be defined', () => {
    expect(gateway).toBeDefined();
  });
});
