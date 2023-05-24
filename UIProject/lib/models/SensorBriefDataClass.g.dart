// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SensorBriefDataClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensorBrief _$SensorBriefFromJson(Map<String, dynamic> json) => SensorBrief(
      DeviceDetails.fromJson(json['details'] as Map<String, dynamic>),
      EventsCaptured.fromJson(json['events'] as Map<String, dynamic>),
      BatteryLevel.fromJson(json['battery'] as Map<String, dynamic>),
      Storage.fromJson(json['storage'] as Map<String, dynamic>),
      CPULoad.fromJson(json['cpuload'] as Map<String, dynamic>),
      TempHumidity.fromJson(json['temphumid'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SensorBriefToJson(SensorBrief instance) =>
    <String, dynamic>{
      'details': instance.details,
      'events': instance.events,
      'battery': instance.battery,
      'storage': instance.storage,
      'cpuload': instance.cpuload,
      'temphumid': instance.temphumid,
    };
