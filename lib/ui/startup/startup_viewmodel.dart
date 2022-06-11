import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/app/app.logger.dart';
import 'package:petdoctor/app/app.router.dart';
import 'package:petdoctor/firestore/fcm.dart';
import 'package:petdoctor/services/update_service.dart';
import 'package:petdoctor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartUpViewModel extends BaseViewModel {
  final _fcmService = locator<FcmService>();
  final _userService = locator<UserService>();
  final _log = getLogger("StartUpViewModel");
  final _navigationService = locator<NavigationService>();

  Future<void> runStartupLogic() async {
    await _fcmService.setupFCM();
    await Future.delayed(const Duration(seconds: 3), () {});

    if (_userService.hasLoggedInUser) {
      _log.v('We have a user session on disk. Sync the user profile ...');

      // getting doctor profile
      await _userService.syncUserAccount();

      if (!_userService.hasProfile) {
        _log.v("User don't have a profile. Navigate to create Profile");
        return _navigationService.replaceWith(Routes.createProfileView,
            arguments: CreateProfileViewArguments(isRejected: false));
      } else if (_userService.hasProfile) {
        /// profile - [rejected]
        if (_userService.currentUser.verified == VerificationStatus.declined) {
          _log.v(
              "User approval request was rejected by admin, allow him to create his profile again.");
          return _navigationService.replaceWith(Routes.createProfileView,
              arguments: CreateProfileViewArguments(isRejected: true));
        }

        /// profile [pending]
        else if (_userService.currentUser.verified ==
            VerificationStatus.review) {
          _log.v(
              "User account yet to be approved. He can accept cases only when approved by admin.");
          return _navigationService.replaceWith(Routes.pendingApproval);
        }

        /// profile [approved]
        else {
          _log.v('We have a user profile, navigate to the HomeView');
          return _navigationService.replaceWith(Routes.mainView);
        }
      }
    }
    // no logged in user
    else {
      _log.v('No user on disk, navigate to the LoginView');
      return _navigationService.replaceWith(Routes.onboardingView);
    }
  }
}
