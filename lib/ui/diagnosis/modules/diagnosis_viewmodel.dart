import 'dart:async';
import 'dart:math';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:petdoctor/api/firestore.dart';
import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/app/app.logger.dart';
import 'package:petdoctor/app/app.router.dart';
import 'package:petdoctor/constants/strings.dart';
import 'package:petdoctor/mixins/dialog.dart';
import 'package:petdoctor/mixins/options.dart';
import 'package:petdoctor/services/user_service.dart';
import 'package:petdoctor/ui/fetch_pharmacies/services/selected_medicines_store.dart';
import 'package:petdoctor/ui/global/call_viewmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked_services/stacked_services.dart';

// part 'medicines.dart';
part 'diagnosis.dart';
part 'treatment.dart';
part 'pharmacies.dart';
part 'medicines.dart';

class DiagnosisViewModel extends BaseCallViewModel
    with CaseSheetOptions, DialogHelper {
  final _firestoreApi = locator<FirestoreApi>();
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();
  final _selectedMedicinesStore = locator<SelectedMedicinesStore>();
  final _log = getLogger('DiagnosisViewModel');

  Treatment? treatment;

  int currentPageIndex = 0;

  String selectedSpecies = '';

  /// Fields for `SpeciesDescription`
  String speciesBreed = "";
  String speciesAge = "";
  String speciesSex = "";

  /// Fields for `CaseHistory`
  String temperature = "";
  String respiration = "";
  String rumination = "";
  String feeding = "";
  String deworming = "";
  String vaccination = "";
  String drinkingWater = "";

  /// TextfieldValues
  String tentativeDiagnosis = "";
  String clinicalSymptoms = "";

  List<Medicine> get selectedMedicines =>
      _selectedMedicinesStore.getSelectedMedicines;
  bool get nearByPharmaciesStatus =>
      _selectedMedicinesStore.getNearByPharmaciesAvailabilityStatus;

  String validateAge(String age) {
    RegExp regex = new RegExp(r"^[0-9]*$");
    if (age.length > 2) {
      return "Please enter valid age";
    } else if (!regex.hasMatch(age)) {
      return "Age should be numeric only";
    } else {
      return "";
    }
  }

  void next() async {
    switch (currentPageIndex) {
      case 0:
        if (speciesSex.isEmpty || speciesAge.isEmpty) {
          Fluttertoast.showToast(msg: kDetailsErrorMessage);
          return;
        }
        var ageCheckMessage = validateAge(speciesAge);
        if (ageCheckMessage != "") {
          Fluttertoast.showToast(msg: ageCheckMessage);
          return;
        }

        break;

      case 1:
        if (temperature.isEmpty |
            respiration.isEmpty |
            feeding.isEmpty |
            deworming.isEmpty |
            vaccination.isEmpty |
            drinkingWater.isEmpty) {
          Fluttertoast.showToast(msg: kDetailsErrorMessage);
          return;
        }

        break;

      case 2:
        if (tentativeDiagnosis.isEmpty) {
          Fluttertoast.showToast(
              msg: 'Tentative Diagnosis should not be empty');
          return;
        }

        break;

      // case 3:
      //   if (pharmacy == null) {
      //     Fluttertoast.showToast(msg: 'Please select any pharmacy to continue');
      //     return;
      //   } else {
      //     _selectedMedicinesStore.clearMedicines();
      //     notifyListeners();
      //   }

      // break;

      case 4:
        if (selectedMedicines.isEmpty) {
          Fluttertoast.showToast(msg: 'Please select medicines');
          return;
        }

        break;

      default:
        {
          await Future.wait([uploadDiagnosis(), disconnect()]);
          _navigationService.back();
          // clear the medicines store
          _selectedMedicinesStore.clearMedicines();
          Fluttertoast.showToast(msg: 'Treatment Success');
        }
    }

    currentPageIndex =
        currentPageIndex == 5 ? currentPageIndex : currentPageIndex + 1;

    notifyListeners();
  }

  void back() {
    currentPageIndex =
        currentPageIndex == 0 ? currentPageIndex : currentPageIndex - 1;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onCallJoin() async {
    selectedSpecies = call.patient.species;

    _log.i("Selected species: ${call.patient.species}");
    await fetchTreatment(call.caseId);
  }
}

extension RuminationCheck on DiagnosisViewModel {
  bool get checkRumination =>
      selectedSpecies == 'cattle' ||
      selectedSpecies == 'buffalo' ||
      selectedSpecies == 'buffalo' ||
      selectedSpecies == 'sheep';
}
