// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/create_profile/create_profile_view.dart';
import '../ui/diagnosis/diagnosis_view.dart';
import '../ui/diagnosis/global_medicines_view.dart';
import '../ui/login/login_view.dart';
import '../ui/main/main_view.dart';
import '../ui/onboarding/onboarding_view.dart';
import '../ui/pending_approval/pending_approval.dart';
import '../ui/pickup/pickup_view.dart';
import '../ui/profile/profile_view.dart';
import '../ui/startup/startup_view.dart';
import '../ui/verify_phone/verify_phone_view.dart';
import '../ui/view_treatment/treatment_details_view.dart';

class Routes {
  static const String startUpView = '/';
  static const String pickupView = '/pickup-view';
  static const String createProfileView = '/create-profile-view';
  static const String loginView = '/login-view';
  static const String verifyPhoneView = '/verify-phone-view';
  static const String onboardingView = '/onboarding-view';
  static const String treatmentDetailsView = '/treatment-details-view';
  static const String diagnosisView = '/diagnosis-view';
  static const String mainView = '/main-view';
  static const String pendingApproval = '/pending-approval';
  static const String profileView = '/profile-view';
  static const String globalMedicinesView = '/global-medicines-view';
  static const all = <String>{
    startUpView,
    pickupView,
    createProfileView,
    loginView,
    verifyPhoneView,
    onboardingView,
    treatmentDetailsView,
    diagnosisView,
    mainView,
    pendingApproval,
    profileView,
    globalMedicinesView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(Routes.pickupView, page: PickupView),
    RouteDef(Routes.createProfileView, page: CreateProfileView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.verifyPhoneView, page: VerifyPhoneView),
    RouteDef(Routes.onboardingView, page: OnboardingView),
    RouteDef(Routes.treatmentDetailsView, page: TreatmentDetailsView),
    RouteDef(Routes.diagnosisView, page: DiagnosisView),
    RouteDef(Routes.mainView, page: MainView),
    RouteDef(Routes.pendingApproval, page: PendingApproval),
    RouteDef(Routes.profileView, page: ProfileView),
    RouteDef(Routes.globalMedicinesView, page: GlobalMedicinesView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartUpView(),
        settings: data,
      );
    },
    PickupView: (data) {
      var args = data.getArgs<PickupViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PickupView(
          key: args.key,
          params: args.params,
        ),
        settings: data,
      );
    },
    CreateProfileView: (data) {
      var args = data.getArgs<CreateProfileViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreateProfileView(
          key: args.key,
          isRejected: args.isRejected,
        ),
        settings: data,
      );
    },
    LoginView: (data) {
      var args = data.getArgs<LoginViewArguments>(
        orElse: () => LoginViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(key: args.key),
        settings: data,
      );
    },
    VerifyPhoneView: (data) {
      var args = data.getArgs<VerifyPhoneViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => VerifyPhoneView(
          key: args.key,
          phoneNumber: args.phoneNumber,
        ),
        settings: data,
      );
    },
    OnboardingView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const OnboardingView(),
        settings: data,
      );
    },
    TreatmentDetailsView: (data) {
      var args = data.getArgs<TreatmentDetailsViewArguments>(
        orElse: () => TreatmentDetailsViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => TreatmentDetailsView(
          key: args.key,
          treatment: args.treatment,
          voicecall: args.voicecall,
        ),
        settings: data,
      );
    },
    DiagnosisView: (data) {
      var args = data.getArgs<DiagnosisViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => DiagnosisView(
          key: args.key,
          channelId: args.channelId,
          navigateToPageIndex: args.navigateToPageIndex,
        ),
        settings: data,
      );
    },
    MainView: (data) {
      var args = data.getArgs<MainViewArguments>(
        orElse: () => MainViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => MainView(key: args.key),
        settings: data,
      );
    },
    PendingApproval: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const PendingApproval(),
        settings: data,
      );
    },
    ProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ProfileView(),
        settings: data,
      );
    },
    GlobalMedicinesView: (data) {
      var args = data.getArgs<GlobalMedicinesViewArguments>(
        orElse: () => GlobalMedicinesViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => GlobalMedicinesView(key: args.key),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// PickupView arguments holder class
class PickupViewArguments {
  final Key? key;
  final Map<String, dynamic> params;
  PickupViewArguments({this.key, required this.params});
}

/// CreateProfileView arguments holder class
class CreateProfileViewArguments {
  final Key? key;
  final bool isRejected;
  CreateProfileViewArguments({this.key, required this.isRejected});
}

/// LoginView arguments holder class
class LoginViewArguments {
  final Key? key;
  LoginViewArguments({this.key});
}

/// VerifyPhoneView arguments holder class
class VerifyPhoneViewArguments {
  final Key? key;
  final String phoneNumber;
  VerifyPhoneViewArguments({this.key, required this.phoneNumber});
}

/// TreatmentDetailsView arguments holder class
class TreatmentDetailsViewArguments {
  final Key? key;
  final Treatment? treatment;
  final Voicecall? voicecall;
  TreatmentDetailsViewArguments({this.key, this.treatment, this.voicecall});
}

/// DiagnosisView arguments holder class
class DiagnosisViewArguments {
  final Key? key;
  final String channelId;
  final int navigateToPageIndex;
  DiagnosisViewArguments(
      {this.key, required this.channelId, this.navigateToPageIndex = 0});
}

/// MainView arguments holder class
class MainViewArguments {
  final Key? key;
  MainViewArguments({this.key});
}

/// GlobalMedicinesView arguments holder class
class GlobalMedicinesViewArguments {
  final Key? key;
  GlobalMedicinesViewArguments({this.key});
}
