import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/ui/diagnosis/global_medicines_view.form.dart';
import 'package:petdoctor/ui/diagnosis/global_medicines_viewmodel.dart';
import 'package:petdoctor/ui/global/iconpack.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(fields: [
  FormTextField(name: "search"),
])
class GlobalMedicinesView extends StatelessWidget with $GlobalMedicinesView {
  GlobalMedicinesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GlobalMedicinesViewModel>.reactive(
      onModelReady: (model) {
        model.getMedicinesFromSupabase();
        model.clearSelectedMedicinesOnInit();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Available Medicines"),
          bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 90),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        UIInput(
                          controller: searchController,
                          appType: AppType.Doctor,
                          placeholder: "Search Your Medicines",
                          onChanged: model.searchMedicines,
                          leading: const Icon(IconPack.search),
                        ),
                      ]))),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(14.0),
            child: model.isBusy
                ? const Text("Fetching Medicines List")
                : model.allMedicinesWithSearch.isEmpty
                    ? const Text("data")
                    : ListView(
                        children: [
                          // show the medicines from actutal medicines list instead of pharmacy medicine ids
                          ...model.allMedicinesWithSearch
                              .map((eachPharmacyMedicine) => GestureDetector(
                                    onTap: () => model.toggleSelectMedicine(
                                        eachPharmacyMedicine),
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                          color: kSurfaceColor,
                                          border: !model.selectedMedicines
                                                  .contains(
                                                      eachPharmacyMedicine)
                                              ? Border.all(
                                                  color:
                                                      const Color(0xFFE9E9EB))
                                              : Border.all(
                                                  color: kSuccessColor),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8))),
                                      child: ListTile(
                                        title: UIText(
                                          eachPharmacyMedicine.name,
                                          size: TxtSize.Small,
                                        ),
                                        subtitle: UIText.paragraph(
                                          "${eachPharmacyMedicine.package} ⸱ ${eachPharmacyMedicine.category}",
                                          color: kTextSecondaryLightColor,
                                          size: TxtSize.Tiny,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ))
                              .toList()
                        ],
                      ),
          ),
        ),
        bottomSheet: Container(
          width: double.infinity,
          height: 80,
          color: kBackgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
          child: UIButton.primary("Select Medicines",
              onTap: () => model.confirmMedicinesAndCreateOrder(),
              appType: AppType.Doctor),
        ),
      ),
      viewModelBuilder: () => GlobalMedicinesViewModel(),
    );
  }
}
