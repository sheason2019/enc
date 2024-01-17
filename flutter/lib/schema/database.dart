import 'package:ENC/schema/excutor/export.dart';
import 'package:drift/drift.dart';
import 'package:ENC/schema/contact.dart';
import 'package:ENC/schema/conversation.dart';
import 'package:ENC/schema/conversation_contact.dart';
import 'package:ENC/schema/message.dart';
import 'package:ENC/schema/message_signature.dart';
import 'package:ENC/schema/message_state.dart';
import 'package:ENC/schema/operation.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/schema/schema_versions.dart';
import 'package:ENC/scope/operator/operate_atom/operate_atom.dart';

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
  AppDatabase(this.accountPath) : super(createExcutor(accountPath));

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
