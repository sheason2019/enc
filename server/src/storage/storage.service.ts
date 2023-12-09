import { Injectable } from '@nestjs/common';
import { Account } from '@prisma/client';
import { createHash } from 'crypto';
import * as path from 'path';
import * as fs from 'fs';
import { sheason_chat } from 'src/prototypes';
import { DATA_ROOT } from 'src/env/env';

@Injectable()
export class StorageService {
  handleUpload(account: Account, wrapper: sheason_chat.SignWrapper): string {
    const filename = Buffer.from(wrapper.sign).toString('base64url');
    const filePath = path.join(DATA_ROOT, account.signPubkey, filename);
    const dir = path.dirname(filePath);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
    fs.writeFileSync(filePath, wrapper.buffer);
    return filename;
  }

  handleMerge(account: Account, wrapper: sheason_chat.SignWrapper): string {
    const filename = Buffer.from(wrapper.buffer).toString('base64url');
    const mergeIdList: string[] = JSON.parse(wrapper.buffer.toString());
    const mergePathList = mergeIdList.map((e) =>
      path.join(DATA_ROOT, account.signPubkey, e),
    );
    const filePath = path.join(DATA_ROOT, account.signPubkey, filename);
    const fileStream = fs.createWriteStream(filePath);
    const hFile = createHash('md5');

    for (const p of mergePathList) {
      const buffer = fs.readFileSync(p);
      fileStream.write(buffer);
      hFile.update(buffer);
    }

    const fileMd5 = hFile.digest();
    fileStream.close();

    return fileMd5.toString('base64url');
  }

  // 删除指定的文件，返回值为删除的文件名
  handleDelete(account: Account, wrapper: sheason_chat.SignWrapper): void {
    const deleteIdList: string[] = JSON.parse(wrapper.buffer.toString());
    const deletePathList = deleteIdList.map((e) =>
      path.join(DATA_ROOT, account.signPubkey, e),
    );

    for (const p of deletePathList) {
      fs.unlinkSync(p);
    }
  }
}
