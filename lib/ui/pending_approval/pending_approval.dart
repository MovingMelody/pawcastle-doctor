import 'package:lottie/lottie.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/constants/assets.dart';
import 'package:flutter/material.dart';

class PendingApproval extends StatelessWidget {
  const PendingApproval({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurfaceColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              "assets/images/processing.json",
              height: 220.0,
            ),
            const UIText.paragraph(
              "\nYour Profile under review.\nPlease wait for the approval.",
              textAlign: TextAlign.center,
              color: kTextPrimaryLightColor,
            ),
            verticalSpaceMedium,
          ],
        )),
      ),
    );
  }
}
