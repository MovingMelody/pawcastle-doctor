import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:petdoctor/app/app.locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MedicineService {
  final _supabase = locator<SupabaseClient>();

  Future<List<GlobalMedicine>> fetchGlobalMedicines() async {
    var result = await _supabase.from('medicines').select().execute();

    List<GlobalMedicine> data = [];

    if (!result.hasError) {
      result.data.forEach((e) => data.add(GlobalMedicine.fromMap(e)));
    }

    return data;
  }
}
