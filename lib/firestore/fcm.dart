import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/app/app.logger.dart';
import 'package:petdoctor/app/app.router.dart';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stacked_services/stacked_services.dart';

class FcmService {
  final _fcm = FirebaseMessaging.instance;
  final _navigationService = locator<NavigationService>();

  final _log = getLogger("FcmService");

  setupFCM() async {
    _log.i("Setting up FCM");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _log.v("New Message from Foreground: ${message.data}");
      _handleNavigation(message.data);
    });
  }

  _handleNavigation(Map<String, dynamic> data) {
    var payload = jsonDecode(data["payload"]);
    var route = payload["route"];
    var params = jsonDecode(payload["params"]);

    switch (route) {
      case Routes.pickupView:
        return _navigationService.navigateTo(route,
            arguments: PickupViewArguments(params: params));
      default:
    }
  }

  Future<String?> generateToken() async => await _fcm.getToken();

  Future<String?> getUpdatedToken(String? token) async {
    var newToken = await _fcm.getToken();
    _log.i(newToken);

    if (newToken != token)
      return newToken;
    else
      return null;
  }
}
