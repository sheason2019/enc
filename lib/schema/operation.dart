import 'package:drift/drift.dart';

class Operations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get clientId => text()();
  IntColumn get clock => integer()();
  TextColumn get payload => text()();
  TextColumn get apply => text()();
}
