import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:otzar/core/errors/app_exception.dart';
import 'package:otzar/core/network/api_client.dart';
import 'package:otzar/features/health/data/repositories/health_repository.dart';

HealthRepository repositoryReturning(http.Response response) {
  return HealthRepository(
    ApiClient(
      baseUrl: 'http://localhost:3000',
      httpClient: MockClient((_) async => response),
    ),
  );
}

void main() {
  test('converte a resposta de GET /health no Model', () async {
    // Arrange
    final repository = repositoryReturning(
      http.Response(
        jsonEncode({
          'status': 'ok',
          'database': 'up',
          'timestamp': '2026-08-30T01:21:08.283Z',
        }),
        200,
      ),
    );

    // Act
    final health = await repository.fetch();

    // Assert
    expect(health.status, 'ok');
    expect(health.database, 'up');
    expect(health.timestamp.toUtc().year, 2026);
  });

  test('traduz o erro da API na mensagem devolvida pelo backend', () async {
    // Arrange
    final repository = repositoryReturning(
      http.Response(
        jsonEncode({
          'statusCode': 503,
          'error': 'Service Unavailable',
          'message': 'Banco de dados indisponível.',
        }),
        503,
      ),
    );

    // Act
    Future<void> act() => repository.fetch();

    // Assert
    await expectLater(
      act,
      throwsA(
        isA<ApiException>()
            .having((e) => e.statusCode, 'statusCode', 503)
            .having((e) => e.message, 'message', 'Banco de dados indisponível.'),
      ),
    );
  });

  test('sinaliza falha de rede quando a API não responde', () async {
    // Arrange
    final repository = HealthRepository(
      ApiClient(
        baseUrl: 'http://localhost:3000',
        httpClient: MockClient((_) async => throw http.ClientException('offline')),
      ),
    );

    // Act
    Future<void> act() => repository.fetch();

    // Assert
    await expectLater(act, throwsA(isA<NetworkException>()));
  });
}
