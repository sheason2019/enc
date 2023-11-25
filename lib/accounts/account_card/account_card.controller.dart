import 'package:get/get.dart';
import 'package:sheason_chat/accounts/accounts.controller.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:sheason_chat/scope/scope.view.dart';

class AccountCardController extends GetxController {
  handleEnterScope(Scope scope) {
    Get.offAll(() => const ScopePage());
  }

  handleDeleteScope(Scope scope) {
    final controller = Get.find<AccountsController>();
    controller.handleDeleteAccount(scope);
  }
}
