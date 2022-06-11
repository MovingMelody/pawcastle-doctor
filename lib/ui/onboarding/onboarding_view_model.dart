import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/app/app.logger.dart';
import 'package:petdoctor/app/app.router.dart';
import 'package:petdoctor/constants/strings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OnboardingViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  final _log = getLogger("OnboardingViewModel");

  navigateToLogin() async {
    var microphoneStatus = await Permission.microphone.status;
    var location = await Permission.location.status;
    var locationWhenInUse = await Permission.locationWhenInUse.status;
    var phoneStatus = await Permission.phone.status;

    if (!location.isGranted) await Permission.location.request();
    if (!microphoneStatus.isGranted) await Permission.microphone.request();
    if (!locationWhenInUse.isGranted)
      await Permission.locationWhenInUse.request();
    if (!phoneStatus.isGranted) await Permission.phone.request();

    if (await Permission.location.isGranted) {
      if (await Permission.microphone.isGranted &&
          await Permission.locationWhenInUse.isGranted &&
          await Permission.phone.isGranted) {
        _navigationService.replaceWith(Routes.loginView);
      } else {
        _log.e(
            "Provide microphone,locationWhenInUse and phone permission to use camera");

        _snackbarService.showSnackbar(
            message: kPermissionErrorMessage,
            mainButtonTitle: "Try again",
            onMainButtonTapped: () => navigateToLogin());
      }
    } else {
      _log.e("Provide location permission to use camera.");
      _snackbarService.showSnackbar(
          message: kPermissionErrorMessage,
          mainButtonTitle: "Try again",
          onMainButtonTapped: () => navigateToLogin());
    }
  }
}
