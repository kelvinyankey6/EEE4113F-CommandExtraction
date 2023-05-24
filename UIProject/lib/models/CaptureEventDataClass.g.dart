// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CaptureEventDataClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptureEvent _$CaptureEventFromJson(Map<String, dynamic> json) => CaptureEvent(
      (json['temperature'] as num).toDouble(),
      (json['humidity'] as num).toDouble(),
      0,
      json['image'] as String,
    );

Map<String, dynamic> _$CaptureEventToJson(CaptureEvent instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'time_taken': instance.time_taken,
      'image': instance.image,
    };
