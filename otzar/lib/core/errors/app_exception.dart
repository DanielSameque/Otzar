/// Falhas conhecidas da aplicação, já traduzidas para uma mensagem exibível.
///
/// O [ApiClient] converte respostas e erros de rede nestes tipos para que as
/// camadas acima não precisem conhecer detalhes de HTTP.
sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// A API não pôde ser alcançada (sem conexão, servidor fora do ar ou timeout).
final class NetworkException extends AppException {
  const NetworkException(super.message);
}

/// A API respondeu, mas rejeitou a operação.
final class ApiException extends AppException {
  const ApiException({required this.statusCode, required String message}) : super(message);

  final int statusCode;
}

/// A API respondeu com um conteúdo diferente do esperado.
final class UnexpectedResponseException extends AppException {
  const UnexpectedResponseException(super.message);
}
