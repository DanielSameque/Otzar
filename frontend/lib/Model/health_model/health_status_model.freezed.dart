// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HealthStatusModel {

 String get status; String get database; DateTime get timestamp;
/// Create a copy of HealthStatusModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HealthStatusModelCopyWith<HealthStatusModel> get copyWith => _$HealthStatusModelCopyWithImpl<HealthStatusModel>(this as HealthStatusModel, _$identity);

  /// Serializes this HealthStatusModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HealthStatusModel&&(identical(other.status, status) || other.status == status)&&(identical(other.database, database) || other.database == database)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,database,timestamp);

@override
String toString() {
  return 'HealthStatusModel(status: $status, database: $database, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $HealthStatusModelCopyWith<$Res>  {
  factory $HealthStatusModelCopyWith(HealthStatusModel value, $Res Function(HealthStatusModel) _then) = _$HealthStatusModelCopyWithImpl;
@useResult
$Res call({
 String status, String database, DateTime timestamp
});




}
/// @nodoc
class _$HealthStatusModelCopyWithImpl<$Res>
    implements $HealthStatusModelCopyWith<$Res> {
  _$HealthStatusModelCopyWithImpl(this._self, this._then);

  final HealthStatusModel _self;
  final $Res Function(HealthStatusModel) _then;

/// Create a copy of HealthStatusModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? database = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,database: null == database ? _self.database : database // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [HealthStatusModel].
extension HealthStatusModelPatterns on HealthStatusModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HealthStatusModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HealthStatusModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HealthStatusModel value)  $default,){
final _that = this;
switch (_that) {
case _HealthStatusModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HealthStatusModel value)?  $default,){
final _that = this;
switch (_that) {
case _HealthStatusModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  String database,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HealthStatusModel() when $default != null:
return $default(_that.status,_that.database,_that.timestamp);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  String database,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _HealthStatusModel():
return $default(_that.status,_that.database,_that.timestamp);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  String database,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _HealthStatusModel() when $default != null:
return $default(_that.status,_that.database,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HealthStatusModel implements HealthStatusModel {
  const _HealthStatusModel({required this.status, required this.database, required this.timestamp});
  factory _HealthStatusModel.fromJson(Map<String, dynamic> json) => _$HealthStatusModelFromJson(json);

@override final  String status;
@override final  String database;
@override final  DateTime timestamp;

/// Create a copy of HealthStatusModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HealthStatusModelCopyWith<_HealthStatusModel> get copyWith => __$HealthStatusModelCopyWithImpl<_HealthStatusModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HealthStatusModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HealthStatusModel&&(identical(other.status, status) || other.status == status)&&(identical(other.database, database) || other.database == database)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,database,timestamp);

@override
String toString() {
  return 'HealthStatusModel(status: $status, database: $database, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$HealthStatusModelCopyWith<$Res> implements $HealthStatusModelCopyWith<$Res> {
  factory _$HealthStatusModelCopyWith(_HealthStatusModel value, $Res Function(_HealthStatusModel) _then) = __$HealthStatusModelCopyWithImpl;
@override @useResult
$Res call({
 String status, String database, DateTime timestamp
});




}
/// @nodoc
class __$HealthStatusModelCopyWithImpl<$Res>
    implements _$HealthStatusModelCopyWith<$Res> {
  __$HealthStatusModelCopyWithImpl(this._self, this._then);

  final _HealthStatusModel _self;
  final $Res Function(_HealthStatusModel) _then;

/// Create a copy of HealthStatusModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? database = null,Object? timestamp = null,}) {
  return _then(_HealthStatusModel(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,database: null == database ? _self.database : database // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
