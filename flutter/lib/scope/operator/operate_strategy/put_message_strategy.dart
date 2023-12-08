import 'package:drift/drift.dart';
import 'package:sheason_chat/cyprto/crypto_utils.dart';
import 'package:sheason_chat/extensions/portable_conversation/portable_conversation.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/schema/database.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_contact_atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_conversatino_anchor_atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_conversation_atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_message_atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_message_signature_atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_message_state_atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_strategy/operate_strategy.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class PutMessageStrategy implements OperateStrategy {
  @override
  final Operation operation;
  @override
  final Scope scope;

  final SignWrapper wrapper;
  PutMessageStrategy({
    required this.scope,
    required this.operation,
    required this.wrapper,
  });

  @override
  Future<void> apply() async {
    final atoms = <OperateAtom>[];

    final signatureProceeder = PutMessageSignatureAtomProceeder();
    final signatureAtom = await signatureProceeder.apply(
      scope,
      Uint8List.fromList(wrapper.sign),
    );
    if (signatureAtom.from != null) {
      final update = scope.db.operations.update();
      update.where((tbl) => tbl.id.equals(operation.id));
      await update.write(OperationsCompanion(
        atoms: Value(atoms),
      ));
      return;
    }

    final secretBox = PortableSecretBox.fromBuffer(wrapper.buffer);
    final buffer = await CryptoUtils.decrypt(scope, secretBox);
    final portableMessage = PortableMessage.fromBuffer(buffer);
    final contactProceeder = PutContactAtomProceeder();
    for (final member in portableMessage.conversation.members) {
      final atom = await contactProceeder.apply(scope, member);
      atoms.add(atom);
    }

    final conversationProceeder = PutConversationAtomProceeder();
    final atom = await conversationProceeder.apply(
      scope,
      portableMessage.conversation,
    );
    atoms.add(atom);

    final agent = portableMessage.conversation.findAgent(scope);
    final selectConversation = scope.db.conversations.select();
    selectConversation.where((tbl) => tbl.signPubkey.equals(agent.signPubKey));
    final conversation = await selectConversation.getSingle();

    if (portableMessage.messageType != MessageType.MESSAGE_TYPE_STATE_ONLY) {
      final selectContact = scope.db.contacts.select();
      selectContact.where(
        (tbl) => tbl.signPubkey.equals(portableMessage.sender.index.signPubKey),
      );
      final contact = await selectContact.getSingle();

      final messageProceeder = PutMessageAtomProceeder(
        contact: contact,
        conversation: conversation,
      );
      final messageAtom = await messageProceeder.apply(scope, portableMessage);
      atoms.add(messageAtom);

      // Conversation Anchor
      final anchorProceeder = PutConversationAnchorAtomProceder();
      final anchorAtom = await anchorProceeder.apply(
        scope,
        portableMessage.conversation,
      );
      atoms.add(anchorAtom);
    }

    final selectMessage = scope.db.messages.select();
    selectMessage.where((tbl) => tbl.uuid.equals(portableMessage.uuid));
    final message = await selectMessage.getSingleOrNull();
    if (message != null) {
      final messageStateProceeder = PutMessageStateAtomProceeder(
        message: message,
      );
      for (final messageState in portableMessage.messageStates) {
        final messageStateAtom = await messageStateProceeder.apply(
          scope,
          messageState,
        );
        atoms.add(messageStateAtom);
      }
    }

    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    await update.write(OperationsCompanion(
      atoms: Value(atoms),
    ));
  }

  @override
  Future<void> revert() async {
    for (final atom in operation.atoms!.reversed) {
      final proceeder = AtomProceeder.fetch(atom);
      await proceeder.revert(scope, atom);
    }

    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    await update.write(const OperationsCompanion(
      atoms: Value(null),
    ));
  }
}
