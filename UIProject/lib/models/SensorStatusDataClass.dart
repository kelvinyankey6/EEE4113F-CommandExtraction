import 'package:json_annotation/json_annotation.dart';

part 'SensorStatusDataClass.g.dart';

@JsonSerializable()
class SensorStatus {

  @JsonKey(defaultValue: false)
  final bool temperature;
  @JsonKey(defaultValue: false)
  final bool humidity;
  @JsonKey(defaultValue: false)
  final bool camera;



  /// Connect the generated [_SensorStatusFromJson] function to the `fromJson`
  /// factory.
  factory SensorStatus.fromJson(Map<String, dynamic> json) =>
      _$SensorStatusFromJson(json);

  SensorStatus(this.temperature, this.humidity, this.camera);

  /// Connect the generated [_SensorStatusToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SensorStatusToJson(this);
}