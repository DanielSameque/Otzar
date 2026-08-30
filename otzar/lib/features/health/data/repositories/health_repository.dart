import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/network/api_client.dart';
import '../models/health_status.dart';

final healthRepositoryProvider = Provider<HealthRepository>(
  (ref) => HealthRepository(ref.watch(apiClientProvider)),
);

class HealthRepository {
  const HealthRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<HealthStatus> fetch() async {
    final payload = await _apiClient.get('/health');

    if (payload is! Map<String, dynamic>) {
      throw const UnexpectedResponseException('A API não retornou um estado de saúde válido.');
    }

    return HealthStatus.fromJson(payload);
  }
}
