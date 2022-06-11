import 'package:petdoctor/ui/global/appbar.dart';
import 'package:petdoctor/ui/login/login_viewmodel.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'login_view.form.dart';

@FormView(fields: [FormTextField(name: "phone")])
class LoginView extends StatelessWidget with $LoginView {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: VetAppbar(onSelected: model.openHelpPopup),
        body: ListView(
          padding: const EdgeInsets.all(15.0),
          children: [
            const UIText.heading(
              "Enter your mobile number",
            ),
            UIInput(
              placeholder: "Mobile Number",
              leading: const Icon(CupertinoIcons.phone),
              controller: phoneController,
              inputType: TextInputType.phone,
              appType: AppType.Doctor,
              helper: "A 6 digit OTP will be sent to verify your number.",
            ),
          ],
        ),
        bottomSheet: Container(
          width: double.infinity,
          color: kBackgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              verticalSpaceRegular,
              UIButton.primary(
                "Continue",
                appType: AppType.Doctor,
                onTap: () => model.navigateToVerify(),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) => listenToFormUpdated(model),
    );
  }
}
