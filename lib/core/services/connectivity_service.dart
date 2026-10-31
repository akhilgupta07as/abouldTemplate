import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityService {
  Stream<bool> get onConnected;

  Future<bool> get isConnected;
}

class ConnectivityPlusService implements ConnectivityService {
  ConnectivityPlusService(this._connectivity);

  final Connectivity _connectivity;

  @override
  Stream<bool> get onConnected {
    return _connectivity.onConnectivityChanged.asyncMap((results) async {
      return _hasConnection(results);
    });
  }

  @override
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return _hasConnection(results);
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return results.any(
      (r) =>
          r == ConnectivityResult.mobile ||
          r == ConnectivityResult.wifi ||
          r == ConnectivityResult.ethernet ||
          r == ConnectivityResult.vpn,
    );
  }
}

class FakeConnectivityService implements ConnectivityService {
  @override
  Stream<bool> get onConnected => Stream.value(true);

  @override
  Future<bool> get isConnected async => true;
}
