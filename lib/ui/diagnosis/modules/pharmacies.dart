part of 'diagnosis_viewmodel.dart';

extension FetchPharmacyViewmodel on DiagnosisViewModel {
  continueToPrescribeFromGlobalMedicines() {
    currentPageIndex++;
    _selectedMedicinesStore.setNearbyPharmaciesAvailabilityStatus(false);
    notifyListeners();
  }

  static String _getOrderId() {
    var r = Random();
    var number =
        String.fromCharCodes(List.generate(7, (index) => r.nextInt(9) + 49));
    return "$number";
  }
}
