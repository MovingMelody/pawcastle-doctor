import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/ui/diagnosis/consumers/treatment_details_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../modules/diagnosis_viewmodel.dart';

class TentativeDiagnosis extends ViewModelWidget<DiagnosisViewModel> {
  TentativeDiagnosis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DiagnosisViewModel model) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        TreatmentDetailsCard(),
        verticalSpaceMedium,
        UIText.label(
          "Diagnosis",
          size: TxtSize.Large,
        ),
        verticalSpaceMedium,
        UIText.label(
          "Clinical Symptoms (Optional)",
          size: TxtSize.Large,
        ),
        verticalSpaceSmall,
        TextFormField(
          autofocus: false,
          decoration: InputDecoration(
            hintText: "Add Clinical Symptoms...",
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: kDoctorColor, width: 1.6),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(
                color: kOutlineColor,
                width: 2.0,
              ),
            ),
          ),
          minLines: 4,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          onChanged: (value) => model.updateClinicalSymptoms(value),
        ),
        verticalSpaceRegular,
        UIText.label(
          "Tentative Diagnosis",
          size: TxtSize.Large,
        ),
        verticalSpaceSmall,
        TextFormField(
          autofocus: false,
          decoration: InputDecoration(
            hintText: "Add Tentative Diagnosis...",
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: kDoctorColor, width: 1.6),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(
                color: kOutlineColor,
                width: 2.0,
              ),
            ),
          ),
          onChanged: (value) => model.updateTentativeDiagnosis(value),
          minLines: 4,
          maxLines: null,
          keyboardType: TextInputType.multiline,
        ),
        verticalSpaceMedium,
      ],
    );
  }
}
