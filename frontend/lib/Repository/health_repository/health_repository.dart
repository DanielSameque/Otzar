import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otzar/Model/health_model/health_status_model.dart';
import 'package:otzar/Service/http_exceptions.dart';
import 'package:otzar/Service/http_service.dart';

final healthRepositoryProvider = Provider<IHealthRepository>(
  (ref) => HttpHealthRepository(ref.watch(apiClientProvider)),
);

/// Contrato de acesso ao estado de saúde da API.
abstract class IHealthRepository {
  Future<HealthStatusModel> fetch();
}

/// Consulta `GET /health` na API do Otzar.
class HttpHealthRepository implements IHealthRepository {
  const HttpHealthRepository(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<HealthStatusModel> fetch() async {
    final payload = await _apiClient.get('/health');

    if (payload is! Map<String, dynamic>) {
      throw const UnexpectedResponseException('A API não retornou um estado de saúde válido.');
    }

    return HealthStatusModel.fromJson(payload);
  }
}
