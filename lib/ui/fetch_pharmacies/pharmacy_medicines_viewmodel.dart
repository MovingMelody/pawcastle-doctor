import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:petdoctor/app/app.logger.dart';
import 'package:petdoctor/services/medicine_service.dart';
import 'package:petdoctor/ui/fetch_pharmacies/services/selected_medicines_store.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';

// make this view model as extension to diagnosis view model
class PharmacyMedicinesViewModel extends BaseViewModel {
  final _log = getLogger("PharmacyMedicinesViewModel");
  final _navigationService = locator<NavigationService>();
  final _medicineService = locator<MedicineService>();
  final _selectedMedicinesStore = locator<SelectedMedicinesStore>();

  // take the medicines ids and populate global medicines list
  List<GlobalMedicine> get availablePhamacyMedicines => _availableMedicines;
  List<GlobalMedicine> _availableMedicines = [];

  List<GlobalMedicine> get allGlobalMedicines => _availableMedicines;

  List<GlobalMedicine> _allMedicines = [];

  List<GlobalMedicine> selectedMedicines = [];
  List<PharmacyMedicine> selectedPharmacyMedicines = [];
  late String selectedPharmacyId;
  String selectedFilterCategory = '';
  List<String> filterChipsSet = [];

  clearSelectedMedicinesOnInit() {
    selectedMedicines = [];
    notifyListeners();
  }

  void getMedicinesFromSupabase() async {
    _log.v("fetching medicines");
    setBusy(true);

    var result = await _medicineService.fetchGlobalMedicines();
    _allMedicines = result;

    _log.v("after fetching medicines from supa");

    for (var eachMedicine in _allMedicines) {
      filterChipsSet.add(eachMedicine.category);
    }

    filterChipsSet = filterChipsSet.toSet().toList();
    setBusy(false);
  }

  toggleSelectMedicine(GlobalMedicine selectedMedicine) {
    selectedMedicines.contains(selectedMedicine)
        ? selectedMedicines.remove(selectedMedicine)
        : selectedMedicines.add(selectedMedicine);
    notifyListeners();
    _log.v(selectedMedicines);
  }

  filterGlobalMedicinesBasedonPharmacyMedicineIds(List<String> medicineIds) {
    _log.v(medicineIds);
    medicineIds = medicineIds.map((e) => e).toList();
    _availableMedicines = _allMedicines
        .where(
            (eachGlobalMedicine) => medicineIds.contains(eachGlobalMedicine.id))
        .toList();
    notifyListeners();
  }
}
