import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sheason_chat/schema/operation.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Operations,
  ],
)
class AppDatabase extends _$AppDatabase {
  final String accountPath;
  AppDatabase(this.accountPath) : super(_openConnection(accountPath));

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection(String accountPath) {
  return LazyDatabase(() async {
    final file = File(path.join(accountPath, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
