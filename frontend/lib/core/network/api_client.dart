import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../errors/app_exception.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  final client = ApiClient();
  ref.onDispose(client.close);
  return client;
});

/// Infraestrutura HTTP compartilhada.
///
/// Conhece apenas transporte, cabeçalhos e erros de rede. A tradução do JSON em
/// Models é responsabilidade dos Repositories.
class ApiClient {
  ApiClient({String? baseUrl, http.Client? httpClient, Duration? timeout})
    : _baseUrl = Uri.parse(baseUrl ?? AppConfig.apiUrl),
      _httpClient = httpClient ?? http.Client(),
      _timeout = timeout ?? const Duration(seconds: 20);

  final Uri _baseUrl;
  final http.Client _httpClient;
  final Duration _timeout;

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) =>
      _send('GET', path, query: query);

  Future<dynamic> post(String path, {Object? body}) => _send('POST', path, body: body);

  Future<dynamic> put(String path, {Object? body}) => _send('PUT', path, body: body);

  Future<dynamic> patch(String path, {Object? body}) => _send('PATCH', path, body: body);

  Future<dynamic> delete(String path) => _send('DELETE', path);

  void close() => _httpClient.close();

  Future<dynamic> _send(
    String method,
    String path, {
    Map<String, dynamic>? query,
    Object? body,
  }) async {
    final request = http.Request(method, _resolve(path, query))
      ..headers.addAll(_headers());

    if (body != null) {
      request.body = jsonEncode(body);
    }

    try {
      final streamed = await _httpClient.send(request).timeout(_timeout);
      return _handle(await http.Response.fromStream(streamed));
    } on TimeoutException {
      throw const NetworkException('A API demorou demais para responder.');
    } on http.ClientException {
      throw const NetworkException('Não foi possível se conectar à API.');
    }
  }

  // Ponto único de montagem dos cabeçalhos: o token de autenticação será
  // adicionado aqui quando o módulo de Autenticação existir.
  Map<String, String> _headers() => const {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Uri _resolve(String path, Map<String, dynamic>? query) {
    final base = _baseUrl.path.endsWith('/')
        ? _baseUrl.path.substring(0, _baseUrl.path.length - 1)
        : _baseUrl.path;
    final suffix = path.startsWith('/') ? path : '/$path';

    return _baseUrl.replace(
      path: '$base$suffix',
      queryParameters: query?.map((key, value) => MapEntry(key, '$value')),
    );
  }

  dynamic _handle(http.Response response) {
    final payload = _decode(response.body);
    final success = response.statusCode >= 200 && response.statusCode < 300;

    if (success) {
      if (response.body.isNotEmpty && payload == null) {
        throw const UnexpectedResponseException('A API retornou um conteúdo inválido.');
      }
      return payload;
    }

    throw ApiException(
      statusCode: response.statusCode,
      message: _messageFrom(payload) ?? 'A API retornou o erro ${response.statusCode}.',
    );
  }

  dynamic _decode(String body) {
    if (body.isEmpty) {
      return null;
    }

    try {
      return jsonDecode(body);
    } on FormatException {
      return null;
    }
  }

  String? _messageFrom(dynamic payload) {
    if (payload is! Map<String, dynamic>) {
      return null;
    }

    final message = payload['message'];

    return switch (message) {
      String text => text,
      List<dynamic> items => items.join('\n'),
      _ => null,
    };
  }
}
