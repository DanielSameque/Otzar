import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_status_model.freezed.dart';
part 'health_status_model.g.dart';

/// Resposta de `GET /health` da API do Otzar.
@freezed
abstract class HealthStatusModel with _$HealthStatusModel {
  const factory HealthStatusModel({
    required String status,
    required String database,
    required DateTime timestamp,
  }) = _HealthStatusModel;

  factory HealthStatusModel.fromJson(Map<String, dynamic> json) =>
      _$HealthStatusModelFromJson(json);
}
