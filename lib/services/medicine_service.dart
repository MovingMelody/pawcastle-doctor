import 'package:flutter/foundation.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:petdoctor/app/app.locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MedicineService {
  final _supabase = locator<SupabaseClient>();

  Future<List<GlobalMedicine>> fetchGlobalMedicines() async {
    // print("executing supabase query");
    var result = await _supabase.from('medicines').select().execute();
    if (kDebugMode) {
      print(result.data);
    }

    // List<GlobalMedicine> data = [];

    // if (!result.hasError) {
    //   result.data.forEach((e) => data.add(GlobalMedicine.fromMap(e)));
    // }

    return [
      globalMedicine1,
      globalMedicine2,
      globalMedicine3,
      globalMedicine4,
      globalMedicine5
    ];
  }
}

GlobalMedicine globalMedicine1 = const GlobalMedicine(
    id: "raksha_hs",
    key: 12,
    name: "name",
    package: "500 ml O.S",
    category: "AntiBiotics",
    mrp: 12.0);
GlobalMedicine globalMedicine2 = const GlobalMedicine(
    id: "raksha_hssdf",
    key: 13,
    name: "Restobal",
    package: "10 ml vial",
    category: "category",
    mrp: 12.0);
GlobalMedicine globalMedicine3 = const GlobalMedicine(
    id: "raksha_hssefdasdfa",
    key: 14,
    name: "Sancimic",
    package: "50 ml vial",
    category: "category",
    mrp: 12.0);
GlobalMedicine globalMedicine4 = const GlobalMedicine(
    id: "raksha_hsadfgjhfsd",
    key: 15,
    name: "Topicure Spray",
    package: "100 Capsules",
    category: "category",
    mrp: 12.0);
GlobalMedicine globalMedicine5 = const GlobalMedicine(
    id: "renerve_plus_capsuls",
    key: 16,
    name: "Replanta",
    package: "15 Capsules",
    category: "Metabolic Aids",
    mrp: 60.0);
