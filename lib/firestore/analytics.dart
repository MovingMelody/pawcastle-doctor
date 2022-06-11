// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:flutter/foundation.dart';
// import 'package:petdoctor/app/app.logger.dart';
// import 'package:petdoctor/enums/events.dart';

// class AnalyticsService {
//   final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
//   final bool appMode;
//   final _log = getLogger('AnalyticsService');

//   FirebaseAnalyticsObserver getAnalyticsObserver() =>
//       FirebaseAnalyticsObserver(analytics: _analytics);

//   AnalyticsService({this.appMode = kReleaseMode});

//   Future logSignup() async => await Future.wait([
//         _analytics.logSignUp(signUpMethod: 'phone'),
//         logEvent(LogEvents.ProfileSignup.event)
//       ]);

//   Future logEvent(String name, {Map<String, dynamic> params = const {}}) async {
//     if (appMode) {
//       _log.i("Logging event $name");
//       await _analytics.logEvent(
//         name: name,
//         parameters: params,
//       );
//     }
//   }

//   Future setUserInfo(String userId) async => Future.wait([
//         _analytics.setUserId(id: userId),
//         _analytics.setUserProperty(name: 'type', value: 'doctor')
//       ]);
// }
