import 'package:json_annotation/json_annotation.dart';

part 'CaptureEventDataClass.g.dart';

@JsonSerializable()
class CaptureEvent {


  final double temperature;
  final double humidity;
  final int time_taken;
  //File name of image
  final String image;

  /// Connect the generated [_CaptureEventFromJson] function to the `fromJson`
  /// factory.
  factory CaptureEvent.fromJson(Map<String, dynamic> json) =>
      _$CaptureEventFromJson(json);

  CaptureEvent(this.temperature, this.humidity, this.time_taken, this.image);

  /// Connect the generated [_CaptureEventToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CaptureEventToJson(this);
}