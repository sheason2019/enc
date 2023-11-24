import 'dart:convert';

import 'package:get/get.dart';
import 'package:sheason_chat/replica/import/import.view.dart';

class ScannerController extends GetxController {
  Future<void> proceedBarcode(String rawValue) async {
    // 若是 Url，则在网络请求后将Body转换为字符串再次执行 proceedBarcode
    final url = Uri.tryParse(rawValue);
    if (url != null) {
      // proceed url
    }

    // 若是 JSON，则执行对应操作
    try {
      final json = jsonDecode(rawValue);
      return _proceedJson(json);
    } catch (e) {
      Get.log('Json unserilize failed. $e');
    }
  }

  Future<void> _proceedJson(dynamic json) async {
    // Replica Account
    switch (json['type']) {
      case 'replica':
        Get.back();
        Get.to(
          () => ImportReplicaPage(
            url: json['url'],
            socketId: json['socketId'],
          ),
        );
      default:
        return;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
