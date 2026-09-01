import {
  ArgumentsHost,
  Catch,
  ExceptionFilter,
  HttpException,
  HttpStatus,
  Logger,
} from '@nestjs/common';
import { Request, Response } from 'express';

interface ErrorBody {
  statusCode: number;
  error: string;
  message: string | string[];
  path: string;
  timestamp: string;
}

// Garante que toda falha da API tenha o mesmo formato de resposta,
// conforme frontend/docs/09-api.md. Erros inesperados não expõem detalhes internos.
@Catch()
export class AllExceptionsFilter implements ExceptionFilter {
  private readonly logger = new Logger(AllExceptionsFilter.name);

  catch(exception: unknown, host: ArgumentsHost): void {
    const context = host.switchToHttp();
    const response = context.getResponse<Response>();
    const request = context.getRequest<Request>();

    const status =
      exception instanceof HttpException
        ? exception.getStatus()
        : HttpStatus.INTERNAL_SERVER_ERROR;

    if (!(exception instanceof HttpException)) {
      this.logger.error(exception);
    }

    response.status(status).json(this.buildBody(exception, status, request.url));
  }

  private buildBody(exception: unknown, status: number, path: string): ErrorBody {
    const base = {
      statusCode: status,
      path,
      timestamp: new Date().toISOString(),
    };

    if (!(exception instanceof HttpException)) {
      return { ...base, error: 'Internal Server Error', message: 'Erro interno do servidor.' };
    }

    const payload = exception.getResponse();

    if (typeof payload === 'string') {
      return { ...base, error: exception.name, message: payload };
    }

    const { error, message } = payload as { error?: string; message?: string | string[] };

    return {
      ...base,
      error: error ?? exception.name,
      message: message ?? exception.message,
    };
  }
}
