import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:sheason_chat/accounts/accounts.view.dart';
import 'package:sheason_chat/prototypes/core.pb.dart';

class HomeController extends GetxController {
  final accountSet = <AccountSecret>{}.obs;
  final currentAccount = Rx<AccountSecret?>(null);

  @override
  void onInit() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Get.off(() => const AccountsPage());
    });
    super.onInit();
  }
}
