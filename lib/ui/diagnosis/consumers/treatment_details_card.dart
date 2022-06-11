import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/mixins/dynamic_assets.dart';
import 'package:petdoctor/ui/diagnosis/modules/diagnosis_viewmodel.dart';
import 'package:petdoctor/utils/date_formatter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TreatmentDetailsCard extends ViewModelWidget<DiagnosisViewModel>
    with DynamicAssets {
  const TreatmentDetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DiagnosisViewModel model) {
    return model.isBusy
        ? Container()
        : model.treatment != null
            ? Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UIText.label(
                        "Case Details",
                        size: TxtSize.Large,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Color(0xffBFF3D0)),
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        child: UIText.label(
                          "ACTIVE",
                          color: kSuccessColor,
                          size: TxtSize.Tiny,
                        ),
                      )
                    ],
                  ),
                  children: [
                    verticalSpaceSmall,
                    Container(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: kOutlineColor),
                              borderRadius: BorderRadius.circular(6)),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    UIText.paragraph(
                                        "Case ID - ${model.treatment?.id}",
                                        size: TxtSize.Small),
                                    verticalSpaceTiny,
                                    UIText.paragraph(
                                        "Name: ${model.treatment?.patient.name}",
                                        size: TxtSize.Small),
                                    verticalSpaceTiny,
                                    UIText.paragraph(
                                        "${DateConverter.formatted(epochString: model.treatment?.timestamp)}",
                                        size: TxtSize.Small),
                                    verticalSpaceTiny,
                                    UIText.paragraph(
                                        "Village/City/Town: \n${model.treatment?.patient.location}",
                                        size: TxtSize.Small),
                                    verticalSpaceTiny,
                                  ],
                                ),
                                Column(
                                  children: [
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
                                          getAsset(
                                              model.treatment!.patient.species),
                                          width: 28.0,
                                        ),
                                      ),
                                    ),
                                    verticalSpaceTiny,
                                    UIText.label(
                                      "Species : ${model.treatment?.patient.name}",
                                      size: TxtSize.Tiny,
                                      color: kDoctorColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            verticalSpaceSmall,
                            // medicines row
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container();
  }
}
