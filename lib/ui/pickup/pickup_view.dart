import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/constants/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'pickup_viewmodel.dart';

class PickupView extends StatelessWidget {
  final Map<String, dynamic> params;

  const PickupView({Key? key, required this.params}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PickupViewModel>.reactive(
      onModelReady: (model) => model.playRingtone(params["play"] == null),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(kUserAsset),
              radius: 80,
            ),
            verticalSpaceLarge,
            UIText.heading(
              "Incoming call",
              textAlign: TextAlign.center,
            ),
            UIText.label(
              params["patient_name"] ?? "Name",
              size: TxtSize.Medium,
              textAlign: TextAlign.center,
            ),
            UIText(
              params["landmark"] ?? "Landmark",
              textAlign: TextAlign.center,
              size: TxtSize.Small,
            ),
          ],
        ),
        bottomSheet: Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                model.isBusy
                    ? CircularProgressIndicator()
                    : IconButton(
                        onPressed: () => model.liftCall(params["channel_id"]),
                        icon: Icon(
                          CupertinoIcons.phone_solid,
                          color: kSuccessColor,
                        )),
                IconButton(
                    onPressed: () => model.back(),
                    icon: Icon(
                      CupertinoIcons.phone_down_fill,
                      color: kErrorColor,
                    ))
              ],
            )),
      ),
      onDispose: (model) => model.stop(),
      viewModelBuilder: () => PickupViewModel(),
    );
  }
}
