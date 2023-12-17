import 'package:flutter/material.dart';
import 'package:sheason_chat/dio.dart';
import 'package:sheason_chat/scope/scope.model.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ServiceResourceController extends ChangeNotifier {
  ServiceResourceController();

  bool get inited => _accountResourceInited && _serverResourceInited;

  Socket? socket;

  var accountUsed = 0;
  int? accountTotal = 0;
  double get accountPercent {
    if (accountTotal == null) {
      return 0;
    } else {
      return accountUsed / accountTotal!;
    }
  }

  var freeMem = 0;
  var totalMem = 0;
  var freeDisk = 0;
  var totalDisk = 0;
  var idleCpuTime = 0;
  var totalCpuTime = 0;
  var onlineAccount = 0;
  var totalAccount = 0;

  var _accountResourceInited = false;
  var _serverResourceInited = false;

  initial(final String url, final Scope scope) async {
    await handleUpdateAccountResource(url, scope);

    final socket = io(
      url,
      OptionBuilder()
          .setPath('/resource.io')
          .setTransports(['websocket'])
          .enableForceNewConnection()
          .disableAutoConnect()
          .build(),
    );

    socket.on('server-resource', (data) {
      freeMem = data['freeMem'];
      totalMem = data['totalMem'];
      freeDisk = data['freeDisk'];
      totalDisk = data['totalDisk'];
      idleCpuTime = data['cpuUsage']['idle'];
      totalCpuTime = data['cpuUsage']['total'];
      onlineAccount = data['onlineAccount'];
      totalAccount = data['totalAccount'];

      _serverResourceInited = true;
      notifyListeners();
    });

    this.socket = socket;
    socket.connect();
  }

  Future<void> handleUpdateAccountResource(
    String url,
    Scope scope,
  ) async {
    final resp = await dio.get('$url/resource/${scope.secret.signPubKey}');
    accountUsed = resp.data['used'];
    accountTotal = resp.data['total'];
    _accountResourceInited = true;
    notifyListeners();
  }

  @override
  void dispose() {
    socket?.dispose();
    super.dispose();
  }
}
