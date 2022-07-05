import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/constants/keys.dart';
import 'package:petdoctor/services/environment_service.dart';
import 'package:package_info/package_info.dart';

class RtcInjection {
  static Future<RtcEngine> getAgoraEngine() async {
    final environnmentService = locator<EnvironmentService>();

    final String _appId = environnmentService.getValue(kAgoraAppId);
    var engine = await RtcEngine.create(_appId);

    await engine.enableAudio();
    await engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await engine.setClientRole(ClientRole.Broadcaster);

    return engine;
  }
}

class PackageInjection {
  /// Injects the regular [PackageInfo] instance instead of [Future]
  static Future<PackageInfo> getInstance() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }
}
