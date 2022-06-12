part of 'diagnosis_viewmodel.dart';

extension PrescriptionModule on DiagnosisViewModel {
  naviateToViewMedicines() {
    _navigationService.navigateTo(Routes.globalMedicinesView);
  }

  addMedicine(Medicine m) => selectedMedicines
          .firstWhere((element) => element.name == m.name, orElse: () {
        selectedMedicines.add(m);
        notifyListeners();
        return m;
      });

  void increaseQty(Medicine medicine) {
    _log.v(medicine.key);
    _log.v(medicine.name);
    _log.v("increment medicine quantity");
    _selectedMedicinesStore.inc(medicine);
    notifyListeners();
  }

  void decreaseQty(Medicine medicine) {
    _log.v("decrementing medicine quantity");
    _selectedMedicinesStore.dec(medicine);
    notifyListeners();
  }
}
