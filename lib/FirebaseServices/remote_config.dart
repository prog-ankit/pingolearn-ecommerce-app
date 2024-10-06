import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfig {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> fetchAndActivate() async {
    await _remoteConfig.fetchAndActivate();
  }

  bool get showDiscountedPrices =>
      _remoteConfig.getBool('showDiscountedPrices');
}
