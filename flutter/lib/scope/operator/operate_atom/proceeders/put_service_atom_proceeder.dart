import 'dart:convert';

import 'package:protobuf/protobuf.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/operator/context.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom_type.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/atom_proceeder.dart';

class PutServiceAtomProceeder implements AtomProceeder<String> {
  @override
  Future<OperateAtom> apply(OperateContext context, String url) async {
    final scope = context.scope;
    final service = PortableService();
    final prevService = scope.snapshot.serviceMap[url];

    final snapshot = scope.snapshot.deepCopy()..serviceMap[url] = service;
    await scope.handleSetSnapshot(snapshot);

    return OperateAtom(
      type: OperateAtomType.putService,
      from: prevService == null
          ? null
          : base64Encode(prevService.writeToBuffer()),
      to: url,
    );
  }

  @override
  Future<void> revert(OperateContext context, OperateAtom atom) async {
    final scope = context.scope;
    final url = atom.to;
    final snapshot = scope.snapshot.deepCopy();
    if (atom.from == null) {
      snapshot.serviceMap.remove(url);
      await scope.handleSetSnapshot(snapshot);
    } else {
      final service = PortableService.fromBuffer(
        base64Decode(atom.from!),
      );
      snapshot.serviceMap[url] = service;
      await scope.handleSetSnapshot(snapshot);
    }
  }
}
