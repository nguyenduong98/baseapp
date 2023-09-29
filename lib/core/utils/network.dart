part of 'utils.dart';

class NetworkUtil {
  NetworkUtil._();

  final _connectivity = Connectivity();
  static final _instance = NetworkUtil._();
  static NetworkUtil get instance => _instance;

  void onConnectivityChanged(ValueChanged<bool>? callback) =>
      _connectivity.onConnectivityChanged
          .distinct()
          .listen((result) => callback?.call(_isConnected(result)))
          .onError((_) {});

  Future<bool> hasInternet() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return _isConnected(result);
    } catch (_) {
      return false;
    }
  }

  bool _isConnected(ConnectivityResult result) {
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;
  }
}
