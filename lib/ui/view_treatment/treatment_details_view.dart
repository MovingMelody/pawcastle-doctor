import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/ui/global/iconpack.dart';
import 'package:petdoctor/ui/view_treatment/treatment_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TreatmentDetailsView extends StatelessWidget {
  final Treatment? treatment;
  final Voicecall? voicecall;

  const TreatmentDetailsView({Key? key, this.treatment, this.voicecall})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TreatmentDetailsViewModel>.reactive(
      onModelReady: (model) =>
          model.onModelReady(viewTreatment: treatment, followupCall: voicecall),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Treatment Details"),
          actions: [
            Visibility(
              visible: model.isJoined,
              child: IconButton(
                  onPressed: () => model.showCallSheet(),
                  icon: const Icon(
                    IconPack.phone,
                    color: kTextPrimaryDarkColor,
                  )),
            )
          ],
        ),
        body: model.isBusy
            ? const CircularProgressIndicator()
            : ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  verticalSpaceMedium,
                  const UIText.label(
                    "Prescribed Medicines",
                    size: TxtSize.Large,
                  ),
                  verticalSpaceSmall,
                  if (model.treatment != null &&
                      model.treatment!.medicines.isNotEmpty)
                    ...model.treatment!.medicines.map((e) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UIText(e.name),
                            UIText(e.quantity.toString() + "x")
                          ],
                        )),
                  verticalSpaceMedium,
                ],
              ),
      ),
      viewModelBuilder: () => TreatmentDetailsViewModel(),
    );
  }
}
