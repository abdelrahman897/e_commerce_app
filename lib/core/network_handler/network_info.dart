import 'package:connectivity_plus/connectivity_plus.dart';

abstract interface class NetworkInfo {
  Future<bool> get isConnected;
}

final class NetworkInfoImp implements NetworkInfo {
  final Connectivity connectivity;
  NetworkInfoImp({required this.connectivity});
  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return _isOnline(result);
  }

  static bool _isOnline(List<ConnectivityResult> results) {
    return results.isNotEmpty &&
        results.any((result) => result != ConnectivityResult.none);
  }
}
