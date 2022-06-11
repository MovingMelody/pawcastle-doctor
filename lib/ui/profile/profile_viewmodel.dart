import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/app/app.router.dart';
import 'package:petdoctor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileViewModel extends BaseViewModel {
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();

  void launchWhatsApp() {
    launch("https://wa.me/+918919225428/?text=${Uri.parse("message")}");
  }

  

  Doctor get currentUser => _userService.currentUser;
}
