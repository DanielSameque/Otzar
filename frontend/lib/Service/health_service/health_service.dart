import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otzar/Model/health_model/health_status_model.dart';
import 'package:otzar/Repository/health_repository/health_repository.dart';

final healthServiceProvider = Provider<HealthService>(
  (ref) => HealthService(ref.watch(healthRepositoryProvider)),
);

/// Operações de diagnóstico da conexão com a API.
class HealthService {
  const HealthService(this._repository);

  final IHealthRepository _repository;

  Future<HealthStatusModel> fetchStatus() => _repository.fetch();
}
