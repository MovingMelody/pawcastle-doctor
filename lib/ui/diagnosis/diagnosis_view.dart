import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/ui/diagnosis/consumers/select_pharmacies.dart';
import 'package:petdoctor/ui/diagnosis/consumers/selected_medicines.dart';
import 'package:petdoctor/ui/diagnosis/consumers/case_history.dart';
import 'package:petdoctor/ui/diagnosis/consumers/tentative_diagnosis.dart';
import 'package:petdoctor/ui/diagnosis/consumers/treatment_summary.dart';
import 'package:petdoctor/ui/global/iconpack.dart';
import 'package:petdoctor/ui/global/lazy_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'consumers/tentative_diagnosis.dart';
import 'consumers/animal_description.dart';
import 'modules/diagnosis_viewmodel.dart';

class DiagnosisView extends StatelessWidget {
  final int navigateToPageIndex;
  DiagnosisView(
      {Key? key, required this.channelId, this.navigateToPageIndex = 0})
      : super(key: key);

  final String channelId;

  final _views = [
    AnimalDescription(),
    CaseHistory(),
    TentativeDiagnosis(),
    const FetchPharmacies(),
    const SelectedMedicines(),
    const TreatmentSummary()
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DiagnosisViewModel>.reactive(
      onModelReady: (model) {
        model.initCall(channelId);
      },
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () =>
              model.showCallExit(exitCall: () => model.disconnect()),
          child: model.isBusy
              ? const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : GestureDetector(
                  child: Scaffold(
                    appBar: AppBar(
                      title: UIText(
                        "Step ${model.currentPageIndex + 1} of ${_views.length}",
                        color: kTextPrimaryLightColor,
                      ),
                      centerTitle: true,
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                      actions: [
                        Visibility(
                          visible: !model.ended,
                          child: IconButton(
                              onPressed: () => model.showCallSheet(),
                              icon: const Icon(
                                IconPack.phone,
                                color: kTextPrimaryLightColor,
                              )),
                        )
                      ],
                      bottom: PreferredSize(
                        preferredSize: const Size(double.infinity, 10),
                        child: LinearProgressIndicator(
                          value: (model.currentPageIndex + 1) / _views.length,
                        ),
                      ),
                    ),
                    body: LazyIndexedStack(
                      itemCount: _views.length,
                      itemBuilder: (BuildContext context, int index) =>
                          _views[index],
                      index: model.currentPageIndex,
                    ),
                    bottomNavigationBar: Container(
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: model.currentPageIndex != 0,
                            child: TextButton(
                                onPressed: () => model.back(),
                                child: const Text("Back")),
                          ),
                          Visibility(
                            visible: model.currentPageIndex != 9,
                            child: ElevatedButton(
                                onPressed: () => model.next(),
                                child: Text(model.currentPageIndex == 5
                                    ? "Finish"
                                    : "Next")),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
      viewModelBuilder: () => DiagnosisViewModel(),
    );
  }
}
