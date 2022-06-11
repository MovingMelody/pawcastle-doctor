import 'dart:async';

import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:flutter/foundation.dart';
import 'package:pawcastle_phoneauth/pawcastle_phoneauth.dart';
import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/app/app.logger.dart';
import 'package:petdoctor/app/app.router.dart';
import 'package:petdoctor/constants/strings.dart';
import 'package:petdoctor/mixins/dialog.dart';
import 'package:petdoctor/services/user_service.dart';
import 'package:petdoctor/utils/popup_mixin.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class VerifyPhoneViewModel extends BaseViewModel
    with OpenHelpMixin, DialogHelper {
  final _firebaseAuthApi = locator<FirebaseAuthApi>();
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  // final _analyticsService = locator<AnalyticsService>();
  final _log = getLogger("VerifyPhoneViewModel");
  final Function(String) updateTextField;

  VerifyPhoneViewModel({required this.updateTextField});

  String? verificationId;
  bool timeOut = kDebugMode;

  StreamSubscription? verifyStream;

  void initPhoneAuth(String phone) {
    verifyStream = _firebaseAuthApi
        .loginWithPhoneNumber(phone: "+91$phone")
        .listen((event) {});

    verifyStream?.onData((event) {
      AuthResult authResult = event;

      // when firebase auto detects OTP, update the OTP and redirect to home
      if (authResult.hasUser) return _loginSuccess(authResult);

      if (authResult.hasToken) {
        verificationId = authResult.verificationId;
        _log.v(
            "VerificationId to perform manual verification: ${authResult.verificationId}");
      }
    });

    verifyStream?.onError((e) {
      _log.e(e);
      _snackbarService.showSnackbar(
          message: "${e?.errorMessage}", title: kDefaultErrorTitle);
    });

    Timer(const Duration(seconds: 20), () {
      timeOut = true;
      notifyListeners();
    });
  }

  void resendCode(phone) => initPhoneAuth(phone);

  void verifyCode(String otp) async {
    if (otp.isEmpty)
      return _snackbarService.showSnackbar(
          message: "Please check your code again");

    setBusy(true);

    var authResult = await _firebaseAuthApi.verifyCode(
        verificationId: verificationId!, codeSent: otp);

    setBusy(false);

    if (authResult.hasUser)
      _loginSuccess(authResult);
    else
      _snackbarService.showSnackbar(message: "Your code is incorrect");
  }

  _loginSuccess(AuthResult authResult) async {
    _log.v("Auto detected sms code: ${authResult.smsCode}");
    updateTextField(authResult.smsCode!);

    setBusy(true);
    // _analyticsService.logEvent(LogEvents.LoginSuccess.event);
    await _userService.syncUserAccount();
    setBusy(false);

    // if user has profile already
    if (_userService.hasProfile) {
      // if user has approved by the admin
      if (_userService.currentUser.verified == VerificationStatus.approved)
        return _navigationService.replaceWith(Routes.mainView);

      // if user register request has rejected by the admin
      if (_userService.currentUser.verified == VerificationStatus.declined) {
        Fluttertoast.showToast(
            msg: "Your account is not approved, Please create profile again.",
            toastLength: Toast.LENGTH_LONG,
            fontSize: 16.0);
        return _navigationService.replaceWith(Routes.createProfileView,
            arguments: CreateProfileViewArguments(isRejected: true));
      }
      // if user yet to be verified by the admin
      if (_userService.currentUser.verified == VerificationStatus.review) {
        Fluttertoast.showToast(
            msg: "Please check back later",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        return _navigationService.replaceWith(Routes.pendingApproval);
      }
    }

    return _navigationService.replaceWith(Routes.createProfileView,
        arguments: CreateProfileViewArguments(isRejected: false));
  }

  @override
  void dispose() {
    verifyStream?.cancel();
    super.dispose();
  }
}
