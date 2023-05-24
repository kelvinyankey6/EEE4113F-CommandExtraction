// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CPULoadDataClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CPULoad _$CPULoadFromJson(Map<String, dynamic> json) => CPULoad(
      (json['cpu_usage'] as num).toDouble(),
      (json['ram_usage'] as num).toDouble(),
    );

Map<String, dynamic> _$CPULoadToJson(CPULoad instance) => <String, dynamic>{
      'cpu_usage': instance.cpu_usage,
      'ram_usage': instance.ram_usage,
    };
