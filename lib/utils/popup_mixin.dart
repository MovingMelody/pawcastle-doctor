import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/services/url_service.dart';

mixin OpenHelpMixin {
  final _openLinkService = locator<OpenLinkService>();

  void openHelpPopup(String help) =>
      _openLinkService.openLink("https://wa.me/+918977033892");
}
