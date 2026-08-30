import { Logger, ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { AllExceptionsFilter } from './common/filters/all-exceptions.filter';

function corsOrigin(): string | string[] {
  const configured = process.env.CORS_ORIGIN?.trim();

  if (!configured || configured === '*') {
    return '*';
  }

  return configured.split(',').map((origin) => origin.trim());
}

async function bootstrap(): Promise<void> {
  const app = await NestFactory.create(AppModule);

  app.enableCors({ origin: corsOrigin() });
  app.useGlobalPipes(
    new ValidationPipe({ whitelist: true, forbidNonWhitelisted: true, transform: true }),
  );
  app.useGlobalFilters(new AllExceptionsFilter());

  const port = Number(process.env.PORT ?? 3000);
  await app.listen(port);

  Logger.log(`Otzar API disponível em http://localhost:${port}`, 'Bootstrap');
}

void bootstrap();
