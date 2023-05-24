// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TempHumidityDataClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TempHumidity _$TempHumidityFromJson(Map<String, dynamic> json) => TempHumidity(
      (json['temperature'] as num).toDouble(),
      (json['humidity'] as num).toDouble(),
    );

Map<String, dynamic> _$TempHumidityToJson(TempHumidity instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'humidity': instance.humidity,
    };
