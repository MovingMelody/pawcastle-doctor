import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/ui/global/appbar.dart';
import 'package:petdoctor/ui/verify_phone/verify_phone_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class VerifyPhoneView extends StatelessWidget {
  final TextEditingController verificationController = TextEditingController();

  final String phoneNumber;

  VerifyPhoneView({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyPhoneViewModel>.reactive(
      onModelReady: (model) => model.initPhoneAuth(phoneNumber),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () => model.showOtpExitDialog(),
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: VetAppbar(onSelected: model.openHelpPopup),
          body: ListView(
            padding: const EdgeInsets.all(15.0),
            children: [
              verticalSpaceMedium,
              const UIText.heading(
                "Enter OTP",
              ),
              verticalSpaceTiny,
              UIText.paragraph(
                "We sent a 6-digit OTP to +91 " + phoneNumber,
                size: TxtSize.Small,
                color: kTextSecondaryLightColor,
              ),
              verticalSpaceMedium,
              UIInput(
                  placeholder: "OTP",
                  leading: const Icon(Icons.code_rounded),
                  inputType: TextInputType.number,
                  appType: AppType.Doctor,
                  controller: verificationController),
              if (model.timeOut)
                Container(
                  alignment: Alignment.centerRight,
                  child: UIButton.tertiary(
                    "Resend code",
                    appType: AppType.Doctor,
                    onTap: () => model.resendCode(phoneNumber),
                  ),
                ),
            ],
          ),
          bottomSheet: model.isBusy
              ? BusyLoader()
              : AnimatedContainer(
                  width: double.infinity,
                  height: 110,
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
                  duration: Duration(milliseconds: 500),
                  child: UIButton.primary(
                    "Verify",
                    onTap: () => model.verifyCode(verificationController.text),
                    appType: AppType.Doctor,
                  ),
                ),
        ),
      ),
      viewModelBuilder: () => VerifyPhoneViewModel(
          updateTextField: (String text) => verificationController.text = text),
    );
  }
}
