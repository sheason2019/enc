import 'package:get/get.dart';
import 'package:sheason_chat/accounts/accounts.view.dart';
import 'package:sheason_chat/barcode/scanner/index.view.dart';

class ChatController extends GetxController {
  handleEnterBarcode() {
    Get.to(() => const BarcodeScannerPage());
  }

  handleEnterAccounts() {
    Get.to(() => const AccountsPage());
  }
}
