import 'package:drift/drift.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/scope.model.dart';

extension ConversationExtension on Conversation {
  Future<PortableConversation> toPortableConversation(Scope scope) async {
    final portable = PortableConversation();
    portable.type = type;
    final select = scope.db.conversationContacts.select().join([
      innerJoin(
        scope.db.contacts,
        scope.db.contacts.id.equalsExp(
          scope.db.conversationContacts.contactId,
        ),
      ),
    ]);
    select.where(scope.db.conversationContacts.conversationId.equals(id));
    final contacts = await select.get();

    portable.members.addAll(
      contacts.map((e) => e.readWithConverter(scope.db.contacts.snapshot)!),
    );

    return portable;
  }
}
