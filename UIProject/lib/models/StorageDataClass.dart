import 'package:json_annotation/json_annotation.dart';

part 'StorageDataClass.g.dart';

@JsonSerializable()
class Storage {

  final double total;
  final double free;
  final double percentage;
  /// Connect the generated [_StorageFromJson] function to the `fromJson`
  /// factory.
  factory Storage.fromJson(Map<String, dynamic> json) =>
      _$StorageFromJson(json);

  Storage(this.total, this.free, this.percentage);

  /// Connect the generated [_StorageToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$StorageToJson(this);
}