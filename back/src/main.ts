import { NestFactory } from '@nestjs/core';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Config
  app.setGlobalPrefix('api')
  // app.useGlobalFilters(new AllExceptionsFilter());

  // Global Swagger
  const options = new DocumentBuilder()
    .setTitle('Docker Summoner')
    .setDescription('Docker Summoner')
    .setVersion('1.0')
    // .addTag('data')
    .build()
  const document = SwaggerModule.createDocument(app, options)
  SwaggerModule.setup('api', app, document)

  await app.listen(process.env.NODE_ENV === 'production' ? 80 : 3001);
}

bootstrap();
