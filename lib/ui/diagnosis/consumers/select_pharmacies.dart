import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/ui/diagnosis/consumers/treatment_details_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../modules/diagnosis_viewmodel.dart';

class FetchPharmacies extends ViewModelWidget<DiagnosisViewModel> {
  const FetchPharmacies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DiagnosisViewModel viewModel) {
    return ListView(padding: const EdgeInsets.all(16.0), children: [
      const TreatmentDetailsCard(),
      verticalSpaceMedium,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          UIText.label(
            "Prescribe Medicines",
            size: TxtSize.Large,
          ),
        ],
      ),
      verticalSpaceMedium,
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          verticalSpaceLarge,
          verticalSpaceMedium,
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UIButton.primary(
                "Continue",
                onTap: () => viewModel.continueToPrescribeFromGlobalMedicines(),
              ),
            ],
          )
        ],
      ),
    ]);
  }
}
