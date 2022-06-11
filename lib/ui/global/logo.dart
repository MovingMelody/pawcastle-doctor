import 'package:petdoctor/constants/assets.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';

class AppbarLogo extends StatelessWidget {
  final String logoImage;
  final String title;
  final Color? titleColor;
  final bool? centerTitle;

  const AppbarLogo(
      {Key? key,
      this.logoImage = kAppIcon,
      this.title = "PawCastle Doctor",
      this.titleColor,
      this.centerTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: centerTitle != false
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Image.asset(
          logoImage,
          height: 38,
          width: 38,
        ),
        horizontalSpaceTiny,
        UIText.label(
          title,
          color: titleColor == null ? kTextPrimaryLightColor : titleColor,
        )
      ],
    );
  }
}
