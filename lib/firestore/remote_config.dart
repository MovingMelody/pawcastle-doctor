import 'package:petdoctor/app/app.logger.dart';
import 'package:petdoctor/constants/keys.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  final _log = getLogger("RemoteConfigService");

  final defaults = <String, dynamic>{kRemoteVersion: 1};

  int get remoteVersionAndroid => _remoteConfig.getInt(kRemoteVersion);

  Future initialise() async {
    try {
      await _remoteConfig.setDefaults(defaults);
      await _fetchAndActivate();
    } catch (e) {
      _log.v(
          'Unable to fetch remote config. Cached or default values will be used');
    }
  }

  Future _fetchAndActivate() async {
    await _remoteConfig.fetch();
    await _remoteConfig.activate();
  }
}
