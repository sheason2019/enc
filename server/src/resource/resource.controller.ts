import { Controller, Get, HttpException, Param } from '@nestjs/common';
import { ResourceService } from './resource.service';
import { AccountService } from 'src/account/account.service';

@Controller('resource')
export class ResourceController {
  constructor(
    private readonly resourceService: ResourceService,
    private readonly accountService: AccountService,
  ) {}

  @Get(':signPubkey')
  async handleGetAccountResource(@Param('signPubkey') signPubkey: string) {
    const account = await this.accountService.find(signPubkey);
    if (!account) {
      throw new HttpException('cannot find account', 404);
    }

    return this.resourceService.getAccountResource(account);
  }
}
