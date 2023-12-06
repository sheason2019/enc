import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sheason_chat/schema/contact.dart';
import 'package:sheason_chat/schema/conversation.dart';
import 'package:sheason_chat/schema/conversation_contact.dart';
import 'package:sheason_chat/schema/message.dart';
import 'package:sheason_chat/schema/message_signature.dart';
import 'package:sheason_chat/schema/message_state.dart';
import 'package:sheason_chat/schema/operation.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/schema_versions.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Operations,
    Contacts,
    Conversations,
    ConversationContacts,
    Messages,
    MessageStates,
    MessageSignatures,
  ],
)
class AppDatabase extends _$AppDatabase {
  final String accountPath;
  AppDatabase(this.accountPath) : super(_openConnection(accountPath));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) => m.createAll(),
      onUpgrade: stepByStep(
        from1To2: (m, schema) async {
          await m.createTable(schema.messageSignatures);
        },
      ),
    );
  }
}

LazyDatabase _openConnection(String accountPath) {
  return LazyDatabase(() async {
    final file = File(path.join(accountPath, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
