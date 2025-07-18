import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider with ChangeNotifier {
  bool _isOnline = true;
  final Connectivity _connectivity = Connectivity();

  bool get isOnline => _isOnline;

  ConnectivityProvider() {
    _initialize();
  }

  void _initialize() async {
    final results = await _connectivity.checkConnectivity();
    _updateConnectionStatus(results);

    _connectivity.onConnectivityChanged.listen((results) {
      _updateConnectionStatus(results);
    });
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final previousStatus = _isOnline;
    // Si *alguna* conexión es válida (wifi o mobile), estás online
    _isOnline = results.any((r) => r != ConnectivityResult.none);

    if (_isOnline != previousStatus) {
      notifyListeners();
    }
  }
}
  