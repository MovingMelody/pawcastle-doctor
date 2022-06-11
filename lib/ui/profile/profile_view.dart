import 'package:petdoctor/constants/assets.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/ui/global/iconpack.dart';
import 'package:petdoctor/ui/global/logo.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const AppbarLogo(
            titleColor: kTextPrimaryDarkColor,
          ),
          elevation: 0,
          backgroundColor: kDoctorColor,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(model.currentUser.image),
                  backgroundColor: Colors.transparent,
                  radius: 30,
                ),
                contentPadding: EdgeInsets.zero,
                title: UIText.label(
                  model.currentUser.name,
                  size: TxtSize.Large,
                ),
                subtitle: UIText.paragraph(
                  model.currentUser.phone,
                  color: kTextSecondaryLightColor,
                )),
            verticalSpaceMedium,
            ListTile(
              leading: const Icon(Icons.people, color: kDoctorColor),
              onTap: () => model.launchWhatsApp(),
              contentPadding: EdgeInsets.zero,
              title: const UIText.label("About Team"),
            ),
            ListTile(
              leading: const Icon(IconPack.headphones, color: kDoctorColor),
              onTap: () => model.launchWhatsApp(),
              contentPadding: EdgeInsets.zero,
              title: const UIText.label("Help & Support"),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}
