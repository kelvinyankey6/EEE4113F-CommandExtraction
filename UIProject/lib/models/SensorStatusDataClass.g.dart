// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SensorStatusDataClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensorStatus _$SensorStatusFromJson(Map<String, dynamic> json) => SensorStatus(
      json['temperature'] as bool? ?? false,
      json['humidity'] as bool? ?? false,
      json['camera'] as bool? ?? false,
    );

Map<String, dynamic> _$SensorStatusToJson(SensorStatus instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'camera': instance.camera,
    };
