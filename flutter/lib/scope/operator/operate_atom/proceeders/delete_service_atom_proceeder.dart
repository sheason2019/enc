import 'dart:convert';

import 'package:protobuf/protobuf.dart';
import 'package:ENC/prototypes/core.pb.dart';
import 'package:ENC/scope/operator/context.dart';
import 'package:ENC/scope/operator/operate_atom/operate_atom.dart';
import 'package:ENC/scope/operator/operate_atom/operate_atom_type.dart';
import 'package:ENC/scope/operator/operate_atom/proceeders/atom_proceeder.dart';

class DeleteServiceAtomProceeder implements AtomProceeder<String> {
  @override
  Future<OperateAtom> apply(OperateContext context, String data) async {
    final scope = context.scope;
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
  Future<void> revert(OperateContext context, OperateAtom atom) async {
    final scope = context.scope;
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
