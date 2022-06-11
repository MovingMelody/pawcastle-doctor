import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/ui/diagnosis/consumers/treatment_details_card.dart';
import 'package:petdoctor/ui/global/medicine_list_item.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../modules/diagnosis_viewmodel.dart';

class SelectedMedicines extends ViewModelWidget<DiagnosisViewModel> {
  const SelectedMedicines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DiagnosisViewModel viewModel) {
    return ListView(padding: const EdgeInsets.all(16.0), children: [
      const TreatmentDetailsCard(),
      verticalSpaceMedium,
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: const UIText.label(
          "Medicines",
          size: TxtSize.Large,
        ),
        trailing: TextButton(
            child: const Text("Add Medicines"),
            onPressed: () => viewModel.naviateToViewMedicines()),
      ),
      ...viewModel.selectedMedicines
          .map((e) => MedicineListItem(
                medicine: e,
                decrement: () => viewModel.decreaseQty(e),
                increment: () => viewModel.increaseQty(e),
              ))
          .toList()
    ]);
  }
}
