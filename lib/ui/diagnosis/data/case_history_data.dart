import 'package:petdoctor/mixins/options.dart';

class DropdownHelper with CaseSheetOptions {
  List<Map<String, dynamic>> get kDropdownData => [
        {
          'title': "Temperature",
          'options': temperatureOptions,
        },
        {
          'title': "Respiration",
          'options': temperatureOptions,
        },
        {
          'title': "Feeding",
          'options': questionOptions,
        },
        {
          'title': "Drinking Water",
          'options': questionOptions,
        },
        {
          'title': "Vaccination",
          'options': questionOptions,
        },
      ];
}
