import 'package:drift/drift.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';

class Conversations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get type => integer().map(ConversationTypeConverter())();
  TextColumn get ecdhPubkey => text()();
  TextColumn get signPubkey => text()();
  BlobColumn get info => blob().map(ConversationInfoTypeConverter())();
}

class ConversationTypeConverter extends TypeConverter<ConversationType, int> {
  @override
  ConversationType fromSql(int fromDb) {
    return ConversationType.valueOf(fromDb) ??
        ConversationType.CONVERSATION_UNKNOWN;
  }

  @override
  int toSql(ConversationType value) {
    return value.value;
  }
}

class ConversationInfoTypeConverter
    extends TypeConverter<PortableConversation, Uint8List> {
  @override
  PortableConversation fromSql(Uint8List fromDb) {
    return PortableConversation.fromBuffer(fromDb);
  }

  @override
  Uint8List toSql(PortableConversation value) {
    return value.writeToBuffer();
  }
}
