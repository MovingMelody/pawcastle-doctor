import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/mixins/dynamic_assets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class TreatementDetailsTile extends StatelessWidget with DynamicAssets {
  final Treatment treatment;
  const TreatementDetailsTile({Key? key, required this.treatment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
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
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
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
                          UIText.paragraph("Case ID - ${treatment.id}",
                              size: TxtSize.Small),
                          verticalSpaceTiny,
                          UIText.paragraph("Name: ${treatment.patient.name}",
                              size: TxtSize.Small),
                          verticalSpaceTiny,
                          UIText.paragraph(treatment.timestamp,
                              size: TxtSize.Small),
                          verticalSpaceTiny,
                          UIText.paragraph(
                              "Village/City/Town: \n${treatment.patient.location}",
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
                                getAsset(treatment.patient.species),
                                width: 28.0,
                              ),
                            ),
                          ),
                          verticalSpaceTiny,
                          UIText.label(
                            "Species : ${treatment.patient.name}",
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
    );
  }
}
