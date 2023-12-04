import 'dart:convert';

import 'package:protobuf/protobuf.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom.dart';
import 'package:sheason_chat/scope/operator/operate_atom/operate_atom_type.dart';
import 'package:sheason_chat/scope/operator/operate_atom/proceeders/atom_proceeder.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class PutServiceAtomProceeder implements AtomProceeder<String> {
  @override
  Future<OperateAtom> apply(Scope scope, String url) async {
    final service = PortableService();
    final prevService = scope.snapshot.serviceMap[url];

    final snapshot = scope.snapshot.deepCopy()..serviceMap[url] = service;
    await scope.handleSetSnapshot(snapshot);

    return OperateAtom(
        type: OperateAtomType.putService,
        from: prevService == null
            ? null
            : base64Encode(prevService.writeToBuffer()),
        to: base64Encode(service.writeToBuffer()),
        extra: {
          'url': url,
        });
  }

  @override
  Future<void> revert(Scope scope, OperateAtom atom) async {
    final url = atom.extra!['url'];
    final snapshot = scope.snapshot.deepCopy();
    if (atom.from == null) {
      snapshot.serviceMap.remove(url);
      await scope.handleSetSnapshot(snapshot);
    } else {
      final service = PortableService.fromBuffer(base64Decode(atom.to));
      snapshot.serviceMap[url] = service;
      await scope.handleSetSnapshot(snapshot);
    }
  }
}
