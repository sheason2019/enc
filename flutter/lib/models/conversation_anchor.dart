import 'package:json_annotation/json_annotation.dart';

part 'conversation_anchor.g.dart';

@JsonSerializable()
class ConversationAnchor {
  List<int> list;
  ConversationAnchor({required this.list});

  factory ConversationAnchor.fromJson(Map<String, dynamic> json) =>
      _$ConversationAnchorFromJson(json);

  Map toJson() => _$ConversationAnchorToJson(this);
}
