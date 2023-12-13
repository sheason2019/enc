import {
  Body,
  Controller,
  Get,
  HttpException,
  Param,
  Post,
  UseInterceptors,
} from '@nestjs/common';
import { NoFilesInterceptor } from '@nestjs/platform-express';
import { IRtcModel } from './rtc.dto';
import { AccountService } from 'src/account/account.service';
import { RtcService } from './rtc.service';
import { sheason_chat } from 'src/prototypes';
import { CryptoService } from 'src/crypto/crypto.service';

@Controller()
export class RtcController {
  constructor(
    private readonly accountService: AccountService,
    private readonly cryptoService: CryptoService,
    private readonly rtcService: RtcService,
  ) {}

  @Post('rtc')
  @UseInterceptors(NoFilesInterceptor())
  async handleCreateRtc(
    @Body()
    body: {
      payload: string;
    },
  ): Promise<IRtcModel> {
    const wrapper = sheason_chat.SignWrapper.decode(
      Buffer.from(body.payload, 'base64'),
    );
    const valid = this.cryptoService.verifySignature(wrapper);
    if (!valid) {
      throw new HttpException('verify signature failed', 403);
    }

    const account = await this.accountService.find(wrapper.signer.signPubKey);
    if (!account) {
      throw new HttpException('cannot find account', 404);
    }

    const model: IRtcModel = JSON.parse(Buffer.from(wrapper.buffer).toString());
    const rtcRecord = await this.rtcService.createRtc(account, model);

    return {
      serviceUrl: rtcRecord.serviceUrl,
      name: rtcRecord.name,
      uuid: rtcRecord.uuid,
    };
  }

  @Get('rtc/:uuid')
  async handleGetRtc(@Param('uuid') uuid: string): Promise<IRtcModel> {
    const record = await this.rtcService.findRtc(uuid);
    if (!record) {
      throw new HttpException('cannot find rtc record', 404);
    }

    return {
      serviceUrl: record.serviceUrl,
      name: record.name,
      uuid: record.uuid,
    };
  }
}
