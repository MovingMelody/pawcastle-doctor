import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/ui/create_profile/create_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfessionProfile extends ViewModelWidget<CreateProfileViewModel> {
  const ProfessionProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, CreateProfileViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UIText.heading(
          "Professional",
          size: TxtSize.Small,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: viewModel.vciLicense == null
              ? UIButton.secondary(
                  "Upload your  License",
                  leadingIcon: Icons.file_copy,
                  onTap: () => viewModel.selectVci(),
                  appType: AppType.Doctor,
                )
              : UIButton.primary(
                  "Upload your  License",
                  leadingIcon: Icons.file_copy,
                  onTap: () => viewModel.selectVci(),
                  appType: AppType.Doctor,
                ),
        ),
      ],
    );
  }
}
