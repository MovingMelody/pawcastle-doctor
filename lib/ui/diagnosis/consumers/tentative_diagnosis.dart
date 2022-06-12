import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/ui/diagnosis/consumers/treatment_details_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../modules/diagnosis_viewmodel.dart';

class TentativeDiagnosis extends ViewModelWidget<DiagnosisViewModel> {
  const TentativeDiagnosis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DiagnosisViewModel viewModel) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const TreatmentDetailsCard(),
        verticalSpaceMedium,
        const UIText.label(
          "Diagnosis",
          size: TxtSize.Large,
        ),
        verticalSpaceSmall,
        TextFormField(
          autofocus: false,
          decoration: InputDecoration(
            hintText: "Add Your Diagnosis...",
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(color: kDoctorColor, width: 1.6),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(
                color: kOutlineColor,
                width: 2.0,
              ),
            ),
          ),
          onChanged: (value) => viewModel.updateTentativeDiagnosis(value),
          minLines: 4,
          maxLines: null,
          keyboardType: TextInputType.multiline,
        ),
        verticalSpaceMedium,
      ],
    );
  }
}
