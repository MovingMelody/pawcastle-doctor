import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/ui/diagnosis/widgets/dropdown_widget.dart';
import 'package:petdoctor/ui/diagnosis/consumers/treatment_details_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../modules/diagnosis_viewmodel.dart';

class AnimalDescription extends ViewModelWidget<DiagnosisViewModel> {
  AnimalDescription({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context, DiagnosisViewModel model) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        TreatmentDetailsCard(),
        verticalSpaceMedium,
        UIText.label(
          "Animal Description",
          size: TxtSize.Large,
        ),
        verticalSpaceMedium,
        DropdownWidget(
          listItems: model.isBusy
              ? []
              : model.getSpeciesCategory(model.selectedSpecies),
          title: "Species Category",
          onChanged: (value) =>
              model.onDropDownSelected('Species Category', value),
          value: model.speciesBreed,
        ),
        UIInput(
          label: "Age",
          appType: AppType.Doctor,
          placeholder: "Enter age",
          controller: controller,
          inputType: TextInputType.number,
          onChanged: (value) => model.updateAge(value),
        ),
        DropdownWidget(
          listItems: model.genderOptions,
          title: "Sex",
          onChanged: (value) => model.onDropDownSelected('Sex', value),
          value: model.speciesSex,
        ),
      ],
    );
  }
}
