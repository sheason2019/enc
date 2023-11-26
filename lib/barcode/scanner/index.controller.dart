import 'dart:convert';

class ScannerController {
  ScannerController._();

  static Future<void> proceedBarcode(String rawValue) async {
    // 若是 Url，则在网络请求后将Body转换为字符串再次执行 proceedBarcode
    final url = Uri.tryParse(rawValue);
    if (url != null) {
      // proceed url
    }

    // 若是 JSON，则执行对应操作

    final json = jsonDecode(rawValue);
    return _proceedJson(json);
  }

  static Future<void> _proceedJson(dynamic json) async {
    // Replica Account
    switch (json['type']) {
      case 'replica':
      // TODO: Goto import replica page
      // Navigator.to(
      //   () => ImportReplicaPage(
      //     url: json['url'],
      //     socketId: json['socketId'],
      //   ),
      // );
      default:
        return;
    }
  }
}
