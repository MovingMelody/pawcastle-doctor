import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/constants/assets.dart';
import 'package:flutter/material.dart';

class VetAppbar extends StatelessWidget implements PreferredSizeWidget {
  const VetAppbar({Key? key, required this.onSelected}) : super(key: key);

  final Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      centerTitle: true,
      title: Container(
        child: Image.asset(
          kAppIcon,
          height: 30,
          width: 30,
        ),
      ),
      actions: [
        PopupMenuButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.keyboard_control_rounded,
            color: kTextPrimaryLightColor,
          ),
          onSelected: onSelected,
          itemBuilder: (BuildContext context) =>
              [PopupMenuItem(child: Text("Help and Support"), value: 'help')],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);
}
