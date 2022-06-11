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
            "Pharmacies",
            size: TxtSize.Large,
          ),
        ],
      ),
      if (viewModel.isBusy) Text("Fetching nearby pharmacies"),
      verticalSpaceMedium,
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            verticalSpaceLarge,
            verticalSpaceLarge,
            const UIText.heading(
              "No nearby pharmacies found. Prescribe medicines without creating order to pharmacy",
              textAlign: TextAlign.center,
              size: TxtSize.Small,
            ),
            verticalSpaceMedium,
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                UIButton.primary(
                  "Prescribe Medicines",
                  onTap: () =>
                      viewModel.continueToPrescribeFromGlobalMedicines(),
                ),
              ],
            )
          ],
        ),
    ]);
  }
}
