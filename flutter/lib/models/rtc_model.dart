import 'package:json_annotation/json_annotation.dart';

part 'rtc_model.g.dart';

@JsonSerializable()
class RtcModel {
  final String name;
  final String uuid;
  final String serviceUrl;

  RtcModel({
    required this.name,
    required this.uuid,
    required this.serviceUrl,
  });

  factory RtcModel.fromJson(Map<String, dynamic> json) =>
      _$RtcModelFromJson(json);
  Map<String, dynamic> toJson() => _$RtcModelToJson(this);
}
