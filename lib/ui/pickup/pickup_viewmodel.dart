import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/app/app.router.dart';
import 'package:petdoctor/services/call_service.dart';
import 'package:petdoctor/services/ringtone_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PickupViewModel extends BaseViewModel {
  final _ringtonePlayer = locator<RingtoneService>();
  final _callService = locator<CallService>();
  final _navigationService = locator<NavigationService>();

  playRingtone(bool play) async => (play) ? _ringtonePlayer.play() : {};

  stop() async => await _ringtonePlayer.stop();

  liftCall(String channelId) async {
    setBusy(true);
    var call = await _callService.fetchCall(channelId);
    setBusy(false);

    if (call != null) if (call.isFollowup) {
      _navigationService.replaceWith(Routes.treatmentDetailsView,
          arguments: TreatmentDetailsViewArguments(voicecall: call));
    } else {
      _navigationService.replaceWith(Routes.diagnosisView,
          arguments: DiagnosisViewArguments(channelId: channelId));
    }
  }

  back() => _navigationService.back();
}
