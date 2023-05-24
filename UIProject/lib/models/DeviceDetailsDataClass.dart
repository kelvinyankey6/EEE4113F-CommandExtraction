import 'package:json_annotation/json_annotation.dart';

part 'DeviceDetailsDataClass.g.dart';

@JsonSerializable()
class DeviceDetails {

  final String device_name;
  final String device_id;

  /// Connect the generated [_DeviceDetailsFromJson] function to the `fromJson`
  /// factory.
  factory DeviceDetails.fromJson(Map<String, dynamic> json) =>
      _$DeviceDetailsFromJson(json);

  DeviceDetails(this.device_name, this.device_id);

  /// Connect the generated [_DeviceDetailsToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DeviceDetailsToJson(this);
}