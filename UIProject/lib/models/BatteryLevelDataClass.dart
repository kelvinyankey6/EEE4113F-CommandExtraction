import 'package:json_annotation/json_annotation.dart';

part 'BatteryLevelDataClass.g.dart';

@JsonSerializable()
class BatteryLevel {


  final double battery_level;

  /// Connect the generated [_BatteryLevelFromJson] function to the `fromJson`
  /// factory.
  factory BatteryLevel.fromJson(Map<String, dynamic> json) =>
      _$BatteryLevelFromJson(json);

  BatteryLevel(this.battery_level);

  /// Connect the generated [_BatteryLevelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BatteryLevelToJson(this);
}