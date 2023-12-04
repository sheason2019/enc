import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:sheason_chat/built_model/serializers.dart';

part 'conversation_anchor.g.dart';

abstract class ConversationAnchor
    implements Built<ConversationAnchor, ConversationAnchorBuilder> {
  static Serializer<ConversationAnchor> get serializer =>
      _$conversationAnchorSerializer;

  BuiltList<int> get list;

  ConversationAnchor._();
  factory ConversationAnchor(
          [void Function(ConversationAnchorBuilder) updates]) =
      _$ConversationAnchor;

  String toJson() => serializers.toJson(serializer, this);

  static ConversationAnchor fromJson(String value) =>
      serializers.fromJson(serializer, value)!;
}
