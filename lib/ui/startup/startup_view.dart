import 'package:lottie/lottie.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/constants/assets.dart';
import 'package:petdoctor/ui/global/logo.dart';
import 'package:petdoctor/ui/startup/startup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      onModelReady: (model) =>
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        model.runStartupLogic();
      }),
      builder: (context, model, child) => Scaffold(
          backgroundColor: kSurfaceColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 LottieBuilder.asset(
                  "assets/images/dogtail.json",
                  height: 220.0,
                ),
                const AppbarLogo(
                  logoImage: kAppIconSecondary,
                  titleColor: kTextPrimaryLightColor,
                ),
               
              ],
            ),
          )),
      viewModelBuilder: () => StartUpViewModel(),
    );
  }
}
