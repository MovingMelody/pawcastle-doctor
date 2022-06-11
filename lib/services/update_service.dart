import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/app/app.logger.dart';
import 'package:petdoctor/firestore/remote_config.dart';
import 'package:package_info/package_info.dart';

class UpdateService {
  final _packageInfo = locator<PackageInfo>();
  final _remoteConfig = locator<RemoteConfigService>();
  final _log = getLogger('UpdateService');

  Future<bool> doForceUpdate() async {
    var version = _packageInfo.buildNumber;
    _log.i("App running with $version");

    await _remoteConfig.initialise();

    int currentAppVersion = int.parse(version);
    int remoteAppVersion = _remoteConfig.remoteVersionAndroid;
    _log.i("Remote Version $remoteAppVersion");

    return currentAppVersion < remoteAppVersion;
  }
}
