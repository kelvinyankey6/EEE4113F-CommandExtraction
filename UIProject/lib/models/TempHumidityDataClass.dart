import 'package:json_annotation/json_annotation.dart';

part 'TempHumidityDataClass.g.dart';

@JsonSerializable()
class TempHumidity {

  final double temperature;
  final double humidity;
  /// Connect the generated [_TempHumidityFromJson] function to the `fromJson`
  /// factory.
  factory TempHumidity.fromJson(Map<String, dynamic> json) =>
      _$TempHumidityFromJson(json);

  TempHumidity(this.temperature, this.humidity);

  /// Connect the generated [_TempHumidityToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TempHumidityToJson(this);
}