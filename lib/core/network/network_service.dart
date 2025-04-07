import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  final Connectivity _connectivity = Connectivity();

  Future<bool> hasConnection() async {
    var result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Stream<ConnectivityResult> onConnectionChange() {
    return _connectivity.onConnectivityChanged.map(
      (results) => results.isNotEmpty ? results.first : ConnectivityResult.none,
    );
  }
}
