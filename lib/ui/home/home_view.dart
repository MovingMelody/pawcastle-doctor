import 'package:dotted_border/dotted_border.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.onModelReady(),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () => model.showExitDialog(),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: UIText.label("Dr. ${model.name}",
                color: kSurfaceColor, size: TxtSize.Large),
            elevation: 0,
            backgroundColor: kDoctorDarkColor,
            actions: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      const UIText(
                        "Accept Orders",
                        size: TxtSize.Tiny,
                      ),
                      Switch(
                        value: model.switchValue,
                        activeColor: kSurfaceColor,
                        onChanged: (value) {
                          model.toggleSwitch(value);
                        },
                      ),
                    ],
                  )),
            ],
          ),
          body: model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () => model.getDoctorTreatments(),
                  child: ListView(
                      padding:
                          const EdgeInsets.symmetric(vertical: 18.0, horizontal: 14),
                      children: [
                        if (model.missedCall.caseId.isNotEmpty &&
                            !model.isExpired)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const UIText.label('Incoming Calls'),
                              Card(
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(8.0),
                                  title: UIText.label(
                                      model.missedCall.patient.name),
                                  subtitle: UIText.paragraph(
                                    model.missedCall.patient.location,
                                    color: kTextSecondaryLightColor,
                                  ),
                                  trailing: IconButton(
                                      onPressed: () => model.acceptCall(),
                                      icon: const Icon(
                                        Icons.call,
                                        color: kSuccessColor,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        verticalSpaceMedium,
                        if (model.allUserTreatments.isEmpty)
                          Center(child: UIText('No Treatments')),
                        if (model.allUserTreatments.isNotEmpty)
                          UIText.label(
                            "Your Treatments",
                            size: TxtSize.Large,
                          ),
                        verticalSpaceTiny,
                        ...model.allUserTreatments.map(
                          (treatment) => Container(
                            child: GestureDetector(
                              onTap: () =>
                                  model.navigateToTreatmentDetails(treatment),
                              child: Container(
                                margin: EdgeInsets.all(6),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: kOutlineColor),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          UIText.label(
                                            (treatment.timestamp),
                                            fontWeight: FontWeight.w500,
                                            color: kTextSecondaryLightColor,
                                            size: TxtSize.Small,
                                          ),
                                          UIText.paragraph(
                                              "ID : " + treatment.id,
                                              size: TxtSize.Small),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 6.0),
                                        child: DottedBorder(
                                          borderType: BorderType.RRect,
                                          dashPattern: [8.0, 6.0],
                                          strokeWidth: 1.5,
                                          strokeCap: StrokeCap.round,
                                          radius: Radius.circular(50),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          color: kOutlineColor,
                                          child: Image.asset(
                                            model.getAsset(
                                                treatment.patient.species),
                                            width: 28.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  verticalSpaceSmall,
                                  // medicines row
                                  Divider(
                                    color: kOutlineColor,
                                    thickness: 1.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(13.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    "assets/images/0.jpg"),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          UIText.paragraph(
                                            treatment.patient.name,
                                            size: TxtSize.Small,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                color: Color(0xffBFF3D0)),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6, horizontal: 10),
                                            child: UIText.label(
                                              "Active",
                                              color: kSuccessColor,
                                              size: TxtSize.Tiny,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ]),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
