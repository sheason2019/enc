import 'dart:convert';

import 'package:protobuf/protobuf.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom_type.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class DeleteServiceAtomProceeder implements AtomProceeder<String> {
  @override
  Future<OperateAtom> apply(Scope scope, String data) async {
    final snapshot = scope.snapshot.deepCopy();
    final removed = snapshot.serviceMap.remove(data);
    await scope.handleSetSnapshot(snapshot);

    return OperateAtom(
        type: OperateAtomType.deleteService,
        from: removed == null ? null : base64Encode(removed.writeToBuffer()),
        to: '',
        extra: {
          'url': data,
        });
  }

  @override
  Future<void> revert(Scope scope, OperateAtom atom) async {
    final from = atom.from;
    final url = atom.extra?['url'];
    if (from == null || url == null) return;
    final snapshot = scope.snapshot.deepCopy();

    final service = PortableService.fromBuffer(
      base64Decode(from),
    );
    snapshot.serviceMap[url] = service;
    await scope.handleSetSnapshot(snapshot);
  }
}
