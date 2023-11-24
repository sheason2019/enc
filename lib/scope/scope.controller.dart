import 'package:get/get.dart';
import 'package:sheason_chat/accounts/accounts.controller.dart';
import 'package:sheason_chat/scope/scope.model.dart';

class ScopeController extends GetxController {
  final Scope scope;
  ScopeController({required this.scope});

  final tabIndex = 0.obs;

  handleSetDefaultScope() async {
    final controller = Get.find<AccountsController>();
    await controller.handleSetDefaultScope(scope);
  }

  @override
  void onInit() {
    handleSetDefaultScope();
    super.onInit();
  }
}
