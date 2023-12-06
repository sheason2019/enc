import 'package:drift/drift.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';

class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get conversationId => integer()();
  IntColumn get contactId => integer()();

  IntColumn get messageType => integer().map(MessageTypeConverter())();
  TextColumn get uuid => text()();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime()();
}

class MessageTypeConverter extends TypeConverter<MessageType, int> {
  @override
  MessageType fromSql(int fromDb) {
    return MessageType.valueOf(fromDb)!;
  }

  @override
  int toSql(MessageType value) {
    return value.value;
  }
}
