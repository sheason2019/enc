import 'package:flutter/material.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class AlterAvatarRemoveDialog extends StatelessWidget {
  final Scope scope;
  const AlterAvatarRemoveDialog({
    super.key,
    required this.scope,
  });

  void handleClick(BuildContext context) async {
    final operation = await scope.operator.factory.avatar('');
    await scope.operator.apply([operation], isReplay: false);

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('警告'),
      contentPadding: const EdgeInsets.all(20),
      content: const Text('此操作将移除现有的用户头像，并恢复至默认头像'),
      actions: [
        TextButton(
          onPressed: () => handleClick(context),
          child: const Text('确认'),
        ),
      ],
    );
  }
}
