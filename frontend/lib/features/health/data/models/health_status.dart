import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_status.freezed.dart';
part 'health_status.g.dart';

/// Resposta de `GET /health` da API do Otzar.
@freezed
abstract class HealthStatus with _$HealthStatus {
  const factory HealthStatus({
    required String status,
    required String database,
    required DateTime timestamp,
  }) = _HealthStatus;

  factory HealthStatus.fromJson(Map<String, dynamic> json) => _$HealthStatusFromJson(json);
}
