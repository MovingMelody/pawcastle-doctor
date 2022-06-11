// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:http/http.dart';
import 'package:pawcastle_phoneauth/pawcastle_phoneauth.dart';
import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_services/stacked_services.dart';

import '../api/firestore.dart';
import '../firestore/fcm.dart';
import '../firestore/remote_config.dart';
import '../services/api_service.dart';
import '../services/call_service.dart';
import '../services/cloud_storage_service.dart';
import '../services/environment_service.dart';
import '../services/medicine_service.dart';
import '../services/notification_service.dart';
import '../services/ringtone_service.dart';
import '../services/update_service.dart';
import '../services/url_service.dart';
import '../services/user_service.dart';
import '../ui/fetch_pharmacies/services/selected_medicines_store.dart';
import '../utils/image_picker.dart';
import 'injection.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  final environmentService = await EnvironmentService.getInstance();
  locator.registerSingleton(environmentService);

  final supabaseInjection = await SupabaseInjection.getSupabase();
  locator.registerSingleton(supabaseInjection);

  final packageInjection = await PackageInjection.getInstance();
  locator.registerSingleton(packageInjection);

  locator.registerLazySingleton(() => UpdateService());
  final rtcInjection = await RtcInjection.getAgoraEngine();
  locator.registerSingleton(rtcInjection);

  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => ImageSelector());
  locator.registerLazySingleton(() => OpenLinkService());
  locator.registerLazySingleton(() => RemoteConfigService());
  locator.registerLazySingleton(() => RingtoneService());
  locator.registerLazySingleton(() => FirebaseAuthApi());
  locator.registerLazySingleton(() => FirestoreApi());
  locator.registerLazySingleton(() => CloudStorageService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => CallService());
  locator.registerLazySingleton(() => FcmService());
  locator.registerLazySingleton(() => MedicineService());
  locator.registerLazySingleton(() => SelectedMedicinesStore());
  locator.registerLazySingleton(() => APIService());
  locator.registerLazySingleton(() => Client());
}
