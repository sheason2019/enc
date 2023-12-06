import 'package:sheason_chat/scope/operator/operate_atom/operate_atom.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom_type.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_contact_atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_conversatino_anchor_atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_conversation_atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_message_atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_message_state_atom_proceeder.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/put_username_atom_proceeder.dart';
import 'package:sheason_chat/scope/scope.model.dart';

import 'put_service_atom_proceeder.dart';

abstract class AtomProceeder<T> {
  Future<OperateAtom> apply(Scope scope, T data);
  Future<void> revert(Scope scope, OperateAtom atom);

  static AtomProceeder<dynamic> fetch(OperateAtom atom) {
    switch (atom.type) {
      case OperateAtomType.putUsername:
        return PutUsernameAtomProceeder();
      case OperateAtomType.putService:
        return PutServiceAtomProceeder();
      case OperateAtomType.putContact:
        return PutContactAtomProceeder();
      case OperateAtomType.putConversation:
        return PutConversationAtomProceeder();
      case OperateAtomType.putConversationAnchor:
        return PutConversationAnchorAtomProceder();
      case OperateAtomType.putMessage:
        return PutMessageAtomProceeder(
          contact: null,
          conversation: null,
        );
      case OperateAtomType.putMessageState:
        return PutMessageStateAtomProceeder(message: null);
      default:
        throw UnimplementedError();
    }
  }
}
