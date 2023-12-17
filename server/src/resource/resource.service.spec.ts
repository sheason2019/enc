import { Test, TestingModule } from '@nestjs/testing';
import { ResourceService } from './resource.service';
import { SubscribeModule } from 'src/subscribe/subscribe.module';

describe('ResourceService', () => {
  let service: ResourceService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [ResourceService],
      imports: [SubscribeModule],
    }).compile();

    service = module.get<ResourceService>(ResourceService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('get server resource', async () => {
    const serverResource = await service.getServerResource();
    console.log('server resource', serverResource);
    console.log(
      'cpu usage',
      1 - serverResource.cpuUsage.idle / serverResource.cpuUsage.total,
    );
  });
});
