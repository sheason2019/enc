import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class EditMemberController extends ChangeNotifier {
  final Scope scope;

  Set<int> _selectSet;
  Set<int> get selectSet => _selectSet;
  set selectSet(Set<int> value) {
    _selectSet = value;
    notifyListeners();
  }

  Set<int> memberSet = {};

  Set<int> disableSet;

  EditMemberController({
    required this.scope,
    Set<int>? selectSet,
    required this.disableSet,
  }) : _selectSet = selectSet ?? {};

  Stream<List<int>> createContactStream() {
    final select = scope.db.contacts.selectOnly();
    select.addColumns([scope.db.contacts.id]);
    return select
        .watch()
        .map((event) => event.map((e) => e.read(scope.db.contacts.id)!))
        .map((event) => event.toList());
  }

  notify() => notifyListeners();
}
