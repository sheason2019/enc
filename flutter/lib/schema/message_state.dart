import 'package:drift/drift.dart';

class MessageStates extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get contactId => integer()();
  IntColumn get messageId => integer()();

  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get receiveAt => dateTime().nullable()();
  DateTimeColumn get checkedAt => dateTime().nullable()();
}
