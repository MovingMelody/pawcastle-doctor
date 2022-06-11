import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/ui/diagnosis/consumers/treatment_details_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../modules/diagnosis_viewmodel.dart';

class TreatmentSummary extends ViewModelWidget<DiagnosisViewModel> {
  const TreatmentSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DiagnosisViewModel viewModel) {
    return ListView(padding: const EdgeInsets.all(16.0), children: [
      TreatmentDetailsCard(),
      verticalSpaceMedium,
      UIText.label(
        "Selected Medicines",
        size: TxtSize.Large,
      ),
      verticalSpaceMedium,
      ...viewModel.selectedMedicines
          .map((e) => ListTile(
                title: UIText.paragraph(e.name),
                subtitle: UIText.paragraph(
                  e.package,
                  color: kTextSecondaryLightColor,
                ),
                trailing: UIText("X${e.quantity}"),
              ))
          .toList()
    ]);
  }
}
