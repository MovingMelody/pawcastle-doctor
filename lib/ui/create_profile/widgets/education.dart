import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/constants/keys.dart';
import 'package:petdoctor/ui/global/creation_aware.dart';
import 'package:petdoctor/ui/create_profile/create_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class EducationProfile extends ViewModelWidget<CreateProfileViewModel> {
  EducationProfile({Key? key}) : super(key: key);

  void listenToFormUpdated(FormViewModel model) {
    bvscController.addListener(() => _updateFormData(model));
    mvscController.addListener(() => _updateFormData(model));
  }

  final TextEditingController bvscController = TextEditingController();
  final TextEditingController mvscController = TextEditingController();
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            kProfileFormBvsc: bvscController.text,
            kProfileFormMvsc: mvscController.text,
          }),
      );

  @override
  Widget build(BuildContext context, CreateProfileViewModel viewModel) {
    return CreationAwareItem(
      onReady: () => listenToFormUpdated(viewModel),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UIText.heading(
            "Education",
            size: TxtSize.Small,
          ),
          UIInput(
              label: "Year of Passing",
              appType: AppType.Doctor,
              placeholder: "Please enter the year",
              inputType: TextInputType.phone,
              controller: bvscController),
          SizedBox(
            width: double.infinity,
            child: viewModel.bvscCertificate == null
                ? UIButton.secondary(
                    "Upload your Certificate",
                    leadingIcon: Icons.file_copy,
                    onTap: () => viewModel.selectBvsc(),
                    appType: AppType.Doctor,
                  )
                : UIButton.primary(
                    "Upload your Certificate",
                    leadingIcon: Icons.file_copy,
                    onTap: () => viewModel.selectBvsc(),
                    appType: AppType.Doctor,
                  ),
          ),
        ],
      ),
    );
  }
}
