import 'package:drift/drift.dart';

class MessageSignatures extends Table {
  IntColumn get id => integer().autoIncrement()();
  BlobColumn get signature => blob()();
}
