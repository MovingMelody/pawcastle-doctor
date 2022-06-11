import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/app/app.logger.dart';
import 'package:petdoctor/app/app.router.dart';
import 'package:petdoctor/constants/keys.dart';
import 'package:petdoctor/services/ringtone_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stacked_services/stacked_services.dart';

class NotificationService {
  final _notificationsPlugin = AwesomeNotifications();
  final _ringtonePlayer = locator<RingtoneService>();
  final _navigationService = locator<NavigationService>();
  final _log = getLogger("NotificationService");

  Future<void> init() async {
    _log.i("Setting up local notifications");

    await _notificationsPlugin.initialize(
      "resource://drawable/app_icon",
      [
        NotificationChannel(
          channelKey: kNotificationChannel,
          channelName: 'Notification',
          importance: NotificationImportance.Max,
          channelDescription: 'Notification channel for doctor app',
        ),
      ],
    );

    _notificationsPlugin.isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        _notificationsPlugin.requestPermissionToSendNotifications();
      }
    });

    _notificationsPlugin.dismissedStream.listen((event) async {
      _log.i("Notification dismissed");
    });

    _notificationsPlugin.actionStream.listen((action) async {
      _log.v("New notification from background $action");

      if (action.buttonKeyPressed == 'accept') {
        var accept = jsonDecode(action.payload!["accept"]!);
        var route = accept["route"];
        var params = accept["params"];

        switch (route) {
          case Routes.diagnosisView:
            return _navigationService.navigateTo(route,
                arguments:
                    DiagnosisViewArguments(channelId: params["channel_id"]));
          default:
        }
      } else if (action.buttonKeyPressed == 'decline') {
        _ringtonePlayer.stop();
      } else {
        var route = action.payload!["route"];

        switch (route) {
          case Routes.pickupView:
            return _navigationService.navigateTo(Routes.pickupView,
                arguments: PickupViewArguments(params: {
                  "play": false,
                  ...jsonDecode(action.payload!["params"]!)
                }));
          default:
        }
      }
    });
  }
}

class BackgroundNotificationHandler {
  BackgroundNotificationHandler._privateConstructor();

  static final BackgroundNotificationHandler _instance =
      BackgroundNotificationHandler._privateConstructor();

  factory BackgroundNotificationHandler() {
    return _instance;
  }

  final _notificationsPlugin = AwesomeNotifications();

  sendNotification(RemoteMessage message) async =>
      await _notificationsPlugin.createNotificationFromJsonData(message.data);
}
