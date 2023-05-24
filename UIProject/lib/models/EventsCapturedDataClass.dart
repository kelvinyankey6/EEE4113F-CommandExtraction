import 'package:json_annotation/json_annotation.dart';

part 'EventsCapturedDataClass.g.dart';

@JsonSerializable()
class EventsCaptured {

  @JsonKey(defaultValue: 0)
  final int events;

  /// Connect the generated [_EventsCapturedFromJson] function to the `fromJson`
  /// factory.
  factory EventsCaptured.fromJson(Map<String, dynamic> json) =>
      _$EventsCapturedFromJson(json);

  EventsCaptured(this.events);

  /// Connect the generated [_EventsCapturedToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$EventsCapturedToJson(this);
}