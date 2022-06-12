import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/ui/diagnosis/data/case_history_data.dart';
import 'package:petdoctor/ui/diagnosis/widgets/dropdown_widget.dart';
import 'package:petdoctor/ui/diagnosis/consumers/treatment_details_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../modules/diagnosis_viewmodel.dart';

class CaseHistory extends ViewModelWidget<DiagnosisViewModel> {
  CaseHistory({Key? key}) : super(key: key);

  final options = DropdownHelper();

  @override
  Widget build(BuildContext context, DiagnosisViewModel viewModel) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const TreatmentDetailsCard(),
        verticalSpaceMedium,
        const UIText.label(
          "Case History",
          size: TxtSize.Large,
        ),
        verticalSpaceRegular,
        ...options.kDropdownData
            .map((e) => e['title'] == 'Rumination'
                ? Visibility(
                    visible: viewModel.checkRumination,
                    child: DropdownWidget(
                        listItems: e['options'],
                        title: e['title'],
                        onChanged: (value) =>
                            viewModel.onDropDownSelected(e['title'], value),
                        value: viewModel.getDropDownLabel(e['title'])))
                : DropdownWidget(
                    listItems: e['options'],
                    title: e['title'],
                    onChanged: (value) =>
                        viewModel.onDropDownSelected(e['title'], value),
                    value: viewModel.getDropDownLabel(e['title'])))
            .toList(),
        verticalSpaceMedium,
      ],
    );
  }
}
