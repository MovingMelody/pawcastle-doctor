part of 'diagnosis_viewmodel.dart';

extension DiagnosisModule on DiagnosisViewModel {
  String getDropDownLabel(String field) {
    switch (field) {
      case 'Temperature':
        return temperature;
      case 'Respiration':
        return respiration;
      case 'Rumination':
        return rumination;
      case 'Feeding':
        return feeding;
      case 'Drinking Water':
        return drinkingWater;
      case 'Deworming':
        return deworming;
      case 'Vaccination':
        return vaccination;
      default:
        return "";
    }
  }

  onDropDownSelected(String field, String value) {
    switch (field) {
      case 'Temperature':
        temperature = value;
        break;
      case 'Respiration':
        respiration = value;
        break;
      case 'Rumination':
        rumination = value;
        break;
      case 'Feeding':
        feeding = value;
        break;
      case 'Drinking Water':
        drinkingWater = value;
        break;
      case 'Deworming':
        deworming = value;
        break;
      case 'Vaccination':
        vaccination = value;
        break;
      case 'Species Category':
        speciesBreed = value;
        break;
      case 'Sex':
        speciesSex = value;
        break;
      default:
        return;
    }

    notifyListeners();
  }

  updateAge(String value) {
    speciesAge = value;
    notifyListeners();
  }

  updateTentativeDiagnosis(String value) {
    tentativeDiagnosis = value;
    notifyListeners();
  }

  updateClinicalSymptoms(String value) {
    clinicalSymptoms = value;
    notifyListeners();
  }
}
