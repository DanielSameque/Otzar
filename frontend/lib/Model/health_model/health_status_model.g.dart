// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HealthStatusModel _$HealthStatusModelFromJson(Map<String, dynamic> json) =>
    _HealthStatusModel(
      status: json['status'] as String,
      database: json['database'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$HealthStatusModelToJson(_HealthStatusModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'database': instance.database,
      'timestamp': instance.timestamp.toIso8601String(),
    };
