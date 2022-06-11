import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/app/app.logger.dart';
import 'package:petdoctor/app/stacked_setup.dart';
import 'package:petdoctor/firebase_options.dart';
import 'package:petdoctor/services/notification_service.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  getLogger("Main").v("Background Message: $message");

  await Firebase.initializeApp();
  await BackgroundNotificationHandler().sendNotification(message);
}

const bool useLocalEmulator = false;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp();
  }
  await FirebaseAppCheck.instance.activate();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  locator.allowReassignment = true;
  await setupLocator();

  if (useLocalEmulator) {
    await _connectToFirebaseEmulator();
  }

  setupStacked();

  await locator<NotificationService>().init();

  runApp(MyApp());
}

/// Connnect to the firebase emulator for Firestore and Authentication
Future _connectToFirebaseEmulator() async {
  // Replace with your IP
  final localHostString = '192.168.1.4';

  FirebaseFirestore.instance.settings = Settings(
    host: '$localHostString:8081',
    sslEnabled: false,
    persistenceEnabled: false,
  );

  FirebaseStorage.instance.useStorageEmulator(localHostString, 9199);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Doctor',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: kTextPrimaryLightColor)),
          primarySwatch: Colors.indigo,
          primaryColor: kDoctorColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'AppFont'),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
