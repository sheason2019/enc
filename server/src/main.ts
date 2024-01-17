import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { prisma } from './prisma/prisma';

async function bootstrap() {
  await prisma.$queryRawUnsafe('PRAGMA journal_mode=WAL;');
  const app = await NestFactory.create(AppModule);
  app.enableCors();
  await app.listen(80);
}
bootstrap();
