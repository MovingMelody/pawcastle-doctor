import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:pawcastle_phoneauth/pawcastle_phoneauth.dart';
import 'package:petdoctor/api/firestore.dart';
import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/app/app.logger.dart';
import 'package:petdoctor/app/app.router.dart';
import 'package:petdoctor/enums/call_status.dart';
import 'package:petdoctor/mixins/dialog.dart';
import 'package:petdoctor/mixins/dynamic_assets.dart';
import 'package:petdoctor/services/call_service.dart';
import 'package:petdoctor/services/user_service.dart';
import 'package:petdoctor/ui/diagnosis/data/default.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel with DynamicAssets, DialogHelper {
  final _userService = locator<UserService>();
  final _firestoreApi = locator<FirestoreApi>();
  final _navigationService = locator<NavigationService>();
  final _firebaseAuthApi = locator<FirebaseAuthApi>();
  final _callService = locator<CallService>();
  final _log = getLogger("HomeViewModel");

  bool switchValue = false;
  bool isExpired = true;

  String get name => _userService.currentUser.name;

  List<Treatment> _doctorTreatments = [];
  List<Treatment> get allUserTreatments => _doctorTreatments;

  Voicecall missedCall = Voicecall.fromMap(kDefaultVoiceCall);

  void toggleSwitch(bool value) {
    _log.v("switching doctor online status: $value");

    switchValue = value;
    _userService.updateStatus(value);

    notifyListeners();
  }

  onModelReady() async {
    setBusy(true);
    await _getMissedCall();
    await getDoctorTreatments();
    setBusy(false);
  }

  _getMissedCall() {
    var currentUser = _firebaseAuthApi.authUser;
    _callService.getMissedCalls(currentUser!.uid).listen((event) {
      if (event != null) {
        missedCall = event;
        isExpired = false;
        notifyListeners();
        handleListening(missedCall.reference);
      }
    });
  }

  handleListening(DocumentReference? ref) {
    ref?.snapshots().listen((event) {
      Voicecall? updatedCall =
          Voicecall.fromMap(event.data() as Map<String, dynamic>);

      _log.i('updated call ${updatedCall.toString()}');

      if (updatedCall.status != CallStatus.Dial.status) {
        isExpired = true;
        notifyListeners();
      }
    });
  }

  showEmpty() => Fluttertoast.showToast(msg: 'Treatment Details are empty');

  acceptCall() {
    if (!missedCall.isFollowup)
      _navigationService.navigateTo(Routes.diagnosisView,
          arguments:
              DiagnosisViewArguments(channelId: missedCall.details.channelId));
    else
      _navigationService.navigateTo(Routes.treatmentDetailsView,
          arguments: TreatmentDetailsViewArguments(voicecall: missedCall));
  }

  getDoctorTreatments() async {
    switchValue = _userService.currentUser.online;

    _log.i("Getting treatments for doctor: ${_userService.currentUser.id}");

    var treatments =
        await _firestoreApi.fetchTreatments(_userService.currentUser.id);

    if (treatments != null) {
      _doctorTreatments = treatments;
    }

    notifyListeners();
  }

  void navigateToTreatmentDetails(Treatment e) {
    _navigationService.navigateTo(Routes.treatmentDetailsView,
        arguments: TreatmentDetailsViewArguments(treatment: e));
  }

  void navigateToProfile() {
    _navigationService.navigateTo(
      Routes.profileView,
    );
  }
}
