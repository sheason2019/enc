import 'package:json_annotation/json_annotation.dart';

part 'network_resource.g.dart';

@JsonSerializable()
class NetworkResource {
  final String url;
  final String name;

  const NetworkResource({
    required this.url,
    required this.name,
  });

  factory NetworkResource.fromJson(Map<String, dynamic> json) =>
      _$NetworkResourceFromJson(json);

  Map toJson() => _$NetworkResourceToJson(this);
}
