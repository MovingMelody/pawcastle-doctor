import 'package:petdoctor/ui/diagnosis/data/breed.dart';

mixin CaseSheetOptions {
  List<String> getSpeciesCategory(String speicies) =>
      kSpeciesBreed[speicies] ?? [];

  List<String> genderOptions = ["Male", "Female"];

  List<String> questionOptions = ["Yes", "No"];

  List<String> temperatureOptions = [
    "Normal",
    "High",
    "Low",
  ];
}
