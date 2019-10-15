import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:ia_mobile/src/commons/enums/ConnectivityStatus.dart';

class ConnectivityServiceNotifier with ChangeNotifier {
  ConnectivityServiceNotifier() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _setStatusFromResult(result);
    });
  }

  ConnectivityStatus _status;

  ConnectivityStatus get getConnectivityStatus => _status;

  void _setStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        _status = ConnectivityStatus.Cellular;
        break;
      case ConnectivityResult.wifi:
        _status = ConnectivityStatus.WiFi;
        break;
      case ConnectivityResult.none:
        _status = ConnectivityStatus.Offline;
        break;
      default:
        _status = ConnectivityStatus.Offline;
    }
    notifyListeners();
  }
}
