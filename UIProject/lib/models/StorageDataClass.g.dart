// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StorageDataClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Storage _$StorageFromJson(Map<String, dynamic> json) => Storage(
      (json['total'] as num).toDouble(),
      (json['free'] as num).toDouble(),
      (json['percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$StorageToJson(Storage instance) => <String, dynamic>{
      'total': instance.total,
      'free': instance.free,
      'percentage': instance.percentage,
    };
