import 'package:lottie/lottie.dart';
import 'package:petdoctor/constants/assets.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/ui/global/logo.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'onboarding_view_model.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(top:80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  AppbarLogo(
                    logoImage: kAppIconSecondary,
                    title: "PawCastle Doctor",
                    titleColor: kTextPrimaryLightColor,
                  ),
                ],
              ),
            ),
            LottieBuilder.asset(
              "assets/images/doctorsintro.json",
              repeat: true,
            ),
            verticalSpaceLarge,
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UIButton(
                title: "Continue",
                onTap: () => model.navigateToLogin(),
                appType: AppType.Doctor,
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => OnboardingViewModel(),
    );
  }
}
