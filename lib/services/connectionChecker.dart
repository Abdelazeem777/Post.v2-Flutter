import 'dart:io';
import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

class ConnectionChecker {
  static final ConnectionChecker _singleton = ConnectionChecker._internal();
  ConnectionChecker._internal();
  factory ConnectionChecker() => _singleton;

  bool _hasConnection = false;
  bool get hasConnection => _hasConnection;

  final _connectionChangeController = StreamController<bool>.broadcast();
  final Connectivity _connectivity = Connectivity();

  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream<bool> get connectionChange => _connectionChangeController.stream;

  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  Future<bool> checkConnection() async {
    bool previousConnection = _hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _hasConnection = true;
      } else {
        _hasConnection = false;
      }
    } on SocketException catch (_) {
      _hasConnection = false;
    }

    if (previousConnection != _hasConnection) {
      _connectionChangeController.add(_hasConnection);
    }

    return _hasConnection;
  }

  void dispose() {
    _connectionChangeController.close();
  }
}
