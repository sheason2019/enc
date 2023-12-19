import * as fs from 'fs';
import * as path from 'path';
import * as os from 'os';
import { Injectable } from '@nestjs/common';
import { Account } from '@prisma/client';
import { prisma } from 'src/prisma/prisma';
import { SubscribeGateway } from 'src/subscribe/subscribe.gateway';
import { DATA_ROOT } from 'src/env/env';

export interface IServerResource {
  freeMem: number;
  totalMem: number;
  freeDisk: number;
  totalDisk: number;
  cpuUsage: {
    idle: number;
    total: number;
  };
  onlineAccount: number;
  totalAccount: number;
}

@Injectable()
export class ResourceService {
  constructor(private readonly subscribeGateway: SubscribeGateway) {}

  async getServerResource(): Promise<IServerResource> {
    // 内存情况
    const freeMem = os.freemem();
    const totalMem = os.totalmem();

    // 磁盘使用情况
    const statfs = fs.statfsSync(DATA_ROOT);
    const freeDisk = statfs.bsize * statfs.bfree;
    const totalDisk = statfs.bsize * statfs.blocks;

    // 获取CPU使用情况
    const cpuUsage = await this.getCpuUsage();

    // 获取当前连接数量
    const onlineAccount = await this.getCurrentConnectionCount();
    // 获取已注册用户数量
    const totalAccount = await prisma.account.count();

    return {
      freeMem,
      totalMem,
      freeDisk,
      totalDisk,
      cpuUsage,
      onlineAccount,
      totalAccount,
    };
  }

  // 账号服务器资源使用情况
  async getAccountResource(
    account: Account,
  ): Promise<{ used: number; total: number | null }> {
    // 统计 Message 使用情况
    const messageLength = await this.getAccountMessageUsage(account);
    // 统计 Storage 使用情况
    const storageLength = await this.getAccountStorageUsage(account);
    // 统计 Operations 使用情况
    const operationLength = await this.getAccountOperationUsage(account);

    return {
      used: messageLength + storageLength + operationLength,
      total: null,
    };
  }

  async getCurrentConnectionCount(): Promise<number> {
    const sockets = await this.subscribeGateway.server?.fetchSockets();
    if (!sockets) return 0;

    return sockets.length;
  }

  async getAccountMessageUsage(account: Account): Promise<number> {
    let length = 0;
    const messages = await prisma.message.findMany({
      where: {
        accounts: {
          some: {
            id: account.id,
          },
        },
      },
    });
    for (const message of messages) {
      length += message.buffer.length;
    }
    return length;
  }

  async getAccountStorageUsage(account: Account): Promise<number> {
    let size = 0;

    const walk = (p: string) => {
      const stat = fs.statSync(p);
      if (stat.isDirectory()) {
        const dir = fs.readdirSync(p);
        for (const childPath of dir) {
          walk(path.join(p, childPath));
        }
        return;
      }
      size = size + stat.size;
    };

    const dirPath = path.join(DATA_ROOT, account.signPubkey);
    if (!fs.existsSync(dirPath)) {
      return 0;
    }

    walk(dirPath);

    return size;
  }

  async getAccountOperationUsage(account: Account): Promise<number> {
    let length = 0;
    const operations = await prisma.operation.findMany({
      where: {
        account,
      },
    });
    for (const operation of operations) {
      length += Buffer.from(operation.data, 'base64').length;
    }

    return length;
  }

  async getCpuUsage(): Promise<{ idle: number; total: number }> {
    const oldSnapshot = this.getCpuUsageSnapshot();
    await new Promise((res) => setTimeout(res, 200));
    const newSnapshot = this.getCpuUsageSnapshot();

    return {
      idle: newSnapshot.idle - oldSnapshot.idle,
      total: newSnapshot.total - oldSnapshot.total,
    };
  }

  getCpuUsageSnapshot(): { idle: number; total: number } {
    let idle = 0;
    let total = 0;

    const cpus = os.cpus();
    for (const cpu of cpus) {
      idle += cpu.times.idle;
      total += Object.values(cpu.times).reduce((acc, tv) => acc + tv, 0);
    }

    return {
      idle,
      total,
    };
  }
}
