import { Injectable } from '@nestjs/common';

@Injectable()
export class ReplicaService {
  generateNamespace(): string {
    const dictionary = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const length = 8;
    const randList = [];
    for (let i = 0; i < length; i++) {
      const rand = Math.floor(Math.random() * dictionary.length);
      randList.push(rand);
    }

    return randList.map((e) => dictionary.at(e)).join('');
  }
}
