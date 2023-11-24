import 'package:get/get.dart';
import 'package:sheason_chat/accounts/accounts.controller.dart';
import 'package:sheason_chat/accounts/accounts.view.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';
import 'package:sheason_chat/scope/scope.view.dart';

class HomeController extends GetxController {
  final accountSet = <AccountSecret>{}.obs;
  final currentAccount = Rx<AccountSecret?>(null);

  @override
  void onInit() async {
    final controller = Get.find<AccountsController>();
    final scope = await controller.handleFindDefaultScope();
    if (scope == null) {
      Get.off(() => const AccountsPage());
    } else {
      Get.off(() => ScopePage(scope: scope));
    }
    super.onInit();
  }
}
