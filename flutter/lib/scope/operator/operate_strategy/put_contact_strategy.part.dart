part of 'batch_operate.dart';

class _PutContactStrategy implements _StrategyBase {
  @override
  final Operation operation;

  @override
  final Scope scope;

  const _PutContactStrategy({
    required this.operation,
    required this.scope,
  });

  @override
  Future<void> apply() async {
    final payload = jsonDecode(operation.payload)['payload'];
    final snapshot = AccountSnapshot.fromBuffer(
      base64Decode(payload['snapshot']),
    );

    final select = scope.db.contacts.select();
    select.where((tbl) => tbl.signPubkey.equals(snapshot.index.signPubKey));
    final exist = await select.getSingleOrNull();
    if (exist != null) {
      // update
      final update = scope.db.contacts.update();
      update.where((tbl) => tbl.id.equals(exist.id));
      await update.replace(ContactsCompanion(
        snapshot: Value(snapshot),
      ));
    } else {
      // insert
      await scope.db.contacts.insertReturning(
        ContactsCompanion.insert(
          signPubkey: snapshot.index.signPubKey,
          snapshot: snapshot,
        ),
      );
    }
    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));

    final apply = {
      'to': base64Encode(snapshot.writeToBuffer()),
    };
    if (exist != null) {
      apply['from'] = base64Encode(exist.snapshot.writeToBuffer());
    } else {
      apply['from'] = 'null';
    }

    await update.replace(OperationsCompanion(
      apply: Value(jsonEncode(apply)),
    ));
  }

  @override
  Future<void> revert() async {
    final json = jsonDecode(operation.apply);
    final from = json['from'];
    final to = AccountSnapshot.fromBuffer(base64Decode(json['to']));

    final select = scope.db.contacts.select();
    select.where((tbl) => tbl.signPubkey.equals(to.index.signPubKey));
    final contact = await select.getSingle();
    if (from == 'null') {
      // delete
      await scope.db.contacts.deleteOne(contact);
    } else {
      // revert
      final snapshot = AccountSnapshot.fromBuffer(
        base64Decode(from),
      );
      final update = scope.db.contacts.update();
      update.where((tbl) => tbl.id.equals(contact.id));
      await update.replace(ContactsCompanion(
        snapshot: Value(snapshot),
      ));
    }

    final update = scope.db.operations.update();
    update.where((tbl) => tbl.id.equals(operation.id));
    await update.replace(const OperationsCompanion(
      apply: Value(''),
    ));
  }
}
