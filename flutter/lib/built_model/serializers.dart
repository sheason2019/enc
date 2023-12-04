library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:sheason_chat/built_model/conversation_anchor.dart';

part 'serializers.g.dart';

/// Collection of generated serializers for the built_value chat example.
@SerializersFor([
  ConversationAnchor,
])
final Serializers serializers = _$serializers;
