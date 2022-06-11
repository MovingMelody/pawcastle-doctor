import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/app/app.router.dart';
import 'package:petdoctor/ui/login/login_view.form.dart';
import 'package:petdoctor/utils/popup_mixin.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends FormViewModel with OpenHelpMixin {
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();

  String errorText = "Please verify the phone number, before you continue";

  void navigateToVerify() {
    if (errorText.isNotEmpty || !hasPhone)
      return _snackbarService.showSnackbar(
          message: errorText, title: "Please enter valid mobile number");

    if (hasPhone)
      _navigationService.navigateTo(Routes.verifyPhoneView,
          arguments: VerifyPhoneViewArguments(phoneNumber: phoneValue!));
  }

  @override
  void setFormStatus() => errorText = validatePhoneNo(phoneValue!);

  String validatePhoneNo(String phone) {
    RegExp regex = new RegExp(r"^[0-9]{10}$");
    if (phone.isEmpty) {
      return "Please enter correct details";
    } else if (!regex.hasMatch(phone)) {
      return "Please enter a valid number";
    } else {
      return "";
    }
  }
}
