import 'dart:async';

import 'package:ENC/scope/scope.model.dart';

class OperateContext {
  final Scope scope;
  final bool isReplay;
  final List<FutureOr<void> Function()> afterTranscation = [];

  OperateContext({
    required this.scope,
    required this.isReplay,
  });
}
