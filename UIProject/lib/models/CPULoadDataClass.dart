import 'package:json_annotation/json_annotation.dart';

part 'CPULoadDataClass.g.dart';

@JsonSerializable()
class CPULoad {


  final double cpu_usage;
  final double ram_usage;

  /// Connect the generated [_CPULoadFromJson] function to the `fromJson`
  /// factory.
  factory CPULoad.fromJson(Map<String, dynamic> json) =>
      _$CPULoadFromJson(json);

  CPULoad(this.cpu_usage, this.ram_usage);

  /// Connect the generated [_CPULoadToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CPULoadToJson(this);
}