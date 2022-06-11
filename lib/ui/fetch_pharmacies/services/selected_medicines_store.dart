import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:petdoctor/app/app.logger.dart';
import 'package:stacked/stacked.dart';

class SelectedMedicinesStore with ReactiveServiceMixin {
  ReactiveList<Medicine> list = ReactiveList();
  List<Medicine> _selectedMedicines = [];
  final _log = getLogger("SelectedMedicinesStore");
  List<Medicine> get getSelectedMedicines => _selectedMedicines;
  bool _nearByPharmaciesFound = true;
  bool get getNearByPharmaciesAvailabilityStatus => _nearByPharmaciesFound;

  clearMedicines() {
    _selectedMedicines = [];
  }

  assignPopulatedMedicines(List<Medicine> selectedMedicineArgs) {
    print("assigned medicines are ");
    selectedMedicineArgs.forEach((e) {
      var medicineKey = e.key;
      var filteredMedicine =
          _selectedMedicines.where((element) => element.key == medicineKey);
      if (filteredMedicine.isEmpty) {
        _selectedMedicines.add(e);
      }
    });
    print(_selectedMedicines);
  }

  setNearbyPharmaciesAvailabilityStatus(bool status) {
    print(
        "No nearby pharmacies found. Doctor preferred to prescribe medicines from global list");

    /// For this scenario no need to deal with payments and tracking order status
    /// order will be closed as soon as doctor finishes prescribing medicines
    _nearByPharmaciesFound = status;
  }

  void inc(Medicine medicine) {
    _log.v("incrementing quantity in store");
    int medicineIndex = -1;
    for (var i = 0; i < _selectedMedicines.length; i++) {
      if (_selectedMedicines[i].key == medicine.key) {
        medicineIndex = i;
        break;
      }
    }
    if (medicineIndex >= 0) {
      _selectedMedicines[medicineIndex] = _selectedMedicines[medicineIndex]
          .copyWithQty(quantity: medicine.quantity + 1);
    }
    _log.v(_selectedMedicines);
  }

  void dec(Medicine medicine) {
    _log.v("decrementing quantity in store");
    int medicineIndex = -1;
    for (var i = 0; i < _selectedMedicines.length; i++) {
      if (_selectedMedicines[i].key == medicine.key) {
        medicineIndex = i;
        break;
      }
    }
    // remove medicine if quantity is already 1, since it will be set to ZERO
    if (medicine.quantity <= 1) {
      _selectedMedicines.removeAt(medicineIndex);
      return;
    }
    if (medicineIndex >= 0) {
      _selectedMedicines[medicineIndex] = _selectedMedicines[medicineIndex]
          .copyWithQty(quantity: medicine.quantity - 1);
    }
    _log.v(_selectedMedicines);
  }
}
