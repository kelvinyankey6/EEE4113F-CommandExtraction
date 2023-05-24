import 'package:json_annotation/json_annotation.dart';

import 'BatteryLevelDataClass.dart';
import 'CPULoadDataClass.dart';
import 'DeviceDetailsDataClass.dart';
import 'EventsCapturedDataClass.dart';
import 'StorageDataClass.dart';
import 'TempHumidityDataClass.dart';

part 'SensorBriefDataClass.g.dart';

@JsonSerializable()
class SensorBrief {


  final DeviceDetails details;
  final EventsCaptured events;
  final BatteryLevel battery;
  final Storage storage;
  final CPULoad cpuload;
  final TempHumidity temphumid;

  /// Connect the generated [_SensorBriefFromJson] function to the `fromJson`
  /// factory.
  factory SensorBrief.fromJson(Map<String, dynamic> json) =>
      _$SensorBriefFromJson(json);

  SensorBrief(this.details, this.events, this.battery, this.storage, this.cpuload, this.temphumid);

  /// Connect the generated [_SensorBriefToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SensorBriefToJson(this);
}