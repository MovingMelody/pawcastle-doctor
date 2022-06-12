import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/app/app.logger.dart';
import 'package:petdoctor/services/medicine_service.dart';
import 'package:petdoctor/ui/fetch_pharmacies/services/selected_medicines_store.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class GlobalMedicinesViewModel extends BaseViewModel {
  final _log = getLogger("GlobalMedicinesViewModel");
  final _navigationService = locator<NavigationService>();
  final _selectedMedicinesStore = locator<SelectedMedicinesStore>();
  final _medicineService = locator<MedicineService>();

  // take the medicines ids and populate global medicines list

  List<GlobalMedicine> _allMedicines = [];
  List<GlobalMedicine> allMedicinesWithSearch = [];
  List<GlobalMedicine> selectedMedicines = [];
  String selectedFilterCategory = '';
  List<String> filterChipsSet = [];

  clearSelectedMedicinesOnInit() {
    selectedMedicines = [];
    notifyListeners();
  }

  searchMedicines(String query) {
    _log.v("user trying to search global medicines");
    allMedicinesWithSearch = [];
    notifyListeners();

    if (query.trim() == "") {
      allMedicinesWithSearch = _allMedicines;
    } else {
      allMedicinesWithSearch = _allMedicines
          .where(
            (eachMedicine) =>
                eachMedicine.name.toLowerCase().contains(query.toLowerCase()) ||
                eachMedicine.composition
                    .toLowerCase()
                    .contains(query.toLowerCase()),
          )
          .toList();
    }

    notifyListeners();
  }

  void getMedicinesFromSupabase() async {
    _log.v("fetching medicines from supabase");
    setBusy(true);

    var result = await _medicineService.fetchGlobalMedicines();
    _allMedicines = result;
    allMedicinesWithSearch = _allMedicines;
    _log.v(_allMedicines);

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

  confirmMedicinesAndCreateOrder() async {
    setBusy(true);
    List<Medicine> list = [];
    // _selectedMedicinesStore.getNearByPharmaciesAvailabilityStatus == false

    _log.v(selectedMedicines.length);
    _log.v("selected medicies list length");

    selectedMedicines.forEach((element) {
      list.add(Medicine(
          id: element.id,
          key: element.key,
          name: element.name,
          package: element.package,
          category: element.category,
          mrp: element.mrp,
          margin: 0,
          inStock: true,
          quantity: 1));
    });
    _log.v("assign global medicines to store - only prescription order");
    await _selectedMedicinesStore.assignPopulatedMedicines(list);
    setBusy(false);
    _navigationService.back();
  }
}
