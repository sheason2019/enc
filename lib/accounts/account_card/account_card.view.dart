import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheason_chat/accounts/account_card/account_card.controller.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class AccountCard extends StatelessWidget {
  final Scope scope;
  const AccountCard({super.key, required this.scope});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountCardController());

    return Obx(
      () => ListTile(
        onTap: () => controller.handleEnterScope(scope),
        onLongPress: () => controller.handleDeleteScope(scope),
        leading: const CircleAvatar(),
        title: Text(
          scope.snapshot.value.username,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          scope.snapshot.value.index.signPubKey,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
