import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/constants/keys.dart';
import 'package:petdoctor/ui/create_profile/create_profile_viewmodel.dart';
import 'package:petdoctor/ui/create_profile/data/animals.dart';
import 'package:petdoctor/ui/global/creation_aware.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PersonalProfile extends ViewModelWidget<CreateProfileViewModel> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void listenToFormUpdated(FormViewModel model) {
    nameController.addListener(() => _updateFormData(model));
    emailController.addListener(() => _updateFormData(model));
  }

  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            kProfileFormName: nameController.text,
            kProfileFormEmail: emailController.text,
          }),
      );

  @override
  Widget build(BuildContext context, CreateProfileViewModel viewModel) {
    return CreationAwareItem(
      onReady: () => listenToFormUpdated(viewModel),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIText.heading(
            "Personal",
            size: TxtSize.Small,
          ),
          verticalSpaceSmall,
          UIInput(
              label: "Name",
              appType: AppType.Doctor,
              placeholder: "Your Full Name",
              leading: Padding(
                padding: EdgeInsets.only(bottom: 16, top: 16.0, left: 16.0),
                child: UIText.label("Dr"),
              ),
              controller: nameController),
          UIText.paragraph("Language"),
          Wrap(
              spacing: 10,
              children: kLanguagesData.keys
                  .map((lang) => ChoiceChip(
                        selectedColor: Colors.black38,
                        label: UIText("${kLanguagesData[lang]}"),
                        onSelected: (bool value) =>
                            viewModel.onLanguageSelected(lang),
                        selected: viewModel.selectedLanguages.contains(lang),
                        labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      ))
                  .toList()),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 16),
            child: viewModel.profileImage != null
                ? UIButton.primary(
                    "Upload your profile image",
                    leadingIcon: Icons.upload_file,
                    onTap: () => viewModel.selectProfile(),
                    appType: AppType.Doctor,
                  )
                : UIButton.secondary(
                    "Upload your profile image",
                    leadingIcon: Icons.upload_file,
                    onTap: () => viewModel.selectProfile(),
                    appType: AppType.Doctor,
                  ),
          ),
        ],
      ),
    );
  }
}
