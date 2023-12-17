import {
  Get,
  Res,
  Post,
  Body,
  Param,
  Controller,
  HttpStatus,
  HttpException,
  UseInterceptors,
} from '@nestjs/common';
import { StorageService } from './storage.service';
import { NoFilesInterceptor } from '@nestjs/platform-express';
import * as fs from 'fs';

import { AccountService } from 'src/account/account.service';
import * as path from 'path';
import { Response } from 'express';
import { sheason_chat } from 'src/prototypes';
import { CryptoService } from 'src/crypto/crypto.service';
import { DATA_ROOT } from 'src/env/env';

@Controller('storage')
export class StorageController {
  constructor(
    private readonly storageService: StorageService,
    private readonly accountService: AccountService,
    private readonly cryptoService: CryptoService,
  ) {}

  @Post(':signPubkey')
  @UseInterceptors(NoFilesInterceptor())
  async postFile(
    @Param('signPubkey') id: string,
    @Body()
    body: { type: 'upload' | 'merge' | 'delete'; payload: string },
  ) {
    const wrapper = sheason_chat.SignWrapper.decode(
      Buffer.from(body.payload, 'base64'),
    );
    const account = await this.accountService.find(id);
    if (!account) {
      throw new HttpException('无法找到指定用户', HttpStatus.FORBIDDEN);
    }

    const verifySign = this.cryptoService.verifySignature(wrapper);
    if (!verifySign) {
      throw new HttpException('invalid signature', 403);
    }

    switch (body.type) {
      case 'upload':
        return this.storageService.handleUpload(account, wrapper);
      case 'merge':
        return this.storageService.handleMerge(account, wrapper);
      case 'delete':
        return this.storageService.handleDelete(account, wrapper);
      default:
        throw new HttpException('未实现的请求类型', HttpStatus.NOT_IMPLEMENTED);
    }
  }

  @Get(':signPubkey/:fileId')
  getFile(
    @Param('signPubkey') signPubkey: string,
    @Param('fileId') fileId: string,
    @Res() res: Response,
  ) {
    // 这是因为 Flutter 的 base64Url 和 Nodejs 的 Base64Url 填充逻辑不同
    // 因此在 Node 端进行一次转换
    const accountScope = Buffer.from(signPubkey, 'base64url').toString(
      'base64url',
    );
    const p = path.join(DATA_ROOT, accountScope, fileId);
    if (!fs.existsSync(p)) {
      throw new HttpException('文件不存在', HttpStatus.NOT_FOUND);
    }

    const file = fs.createReadStream(p);
    file.pipe(res);
  }

  @Get(':signPubkey/:fileId/size')
  async getFileSize(
    @Param('signPubkey') signPubkey: string,
    @Param('fileId') fileId: string,
  ) {
    // 这是因为 Flutter 的 base64Url 和 Nodejs 的 Base64Url 填充逻辑不同
    // 因此在 Node 端进行一次转换
    const accountScope = Buffer.from(signPubkey, 'base64url').toString(
      'base64url',
    );
    const p = path.join(DATA_ROOT, accountScope, fileId);
    if (!fs.existsSync(p)) {
      throw new HttpException('文件不存在', HttpStatus.NOT_FOUND);
    }

    return fs.statSync(p).size;
  }
}
