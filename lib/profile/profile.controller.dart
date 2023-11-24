import 'package:get/get.dart';
import 'package:sheason_chat/replica/export/export.view.dart';

class ProfileController extends GetxController {
  handleExportReplica() {
    Get.to(() => const ExportReplicaPage());
  }
}
