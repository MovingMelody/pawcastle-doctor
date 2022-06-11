import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:petdoctor/api/firestore.dart';
import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/mixins/dynamic_assets.dart';
import 'package:petdoctor/ui/global/call_viewmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TreatmentDetailsViewModel extends BaseCallViewModel with DynamicAssets {
  final _firestoreApi = locator<FirestoreApi>();

  Treatment? treatment;
  TreatmentDiagnosis? diagnosis;

  onModelReady({Treatment? viewTreatment, Voicecall? followupCall}) async {
    setBusy(true);

    if (viewTreatment == null) {
      Fluttertoast.showToast(msg: "Joining call...");
      await initCall(followupCall!.id);
    } else {
      this.treatment = viewTreatment;
    }
    setBusy(false);
  }

  @override
  Future<void> onCallJoin() async {
    if (treatment != null) return;
    setBusy(true);
    var result = await _firestoreApi.getTreatment(call.caseId);

    if (result is Treatment) {
      treatment = result;
    }
  }
}
