import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/ui/create_profile/widgets/education.dart';
import 'package:petdoctor/ui/create_profile/widgets/personal.dart';
import 'package:petdoctor/ui/create_profile/widgets/profession.dart';
import 'package:petdoctor/ui/global/appbar.dart';
import 'package:petdoctor/ui/global/lazy_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'create_profile_viewmodel.dart';

class CreateProfileView extends StatelessWidget {
  CreateProfileView({Key? key, required this.isRejected}) : super(key: key);

  final bool isRejected;

  final _views = [PersonalProfile(), EducationProfile(), ProfessionProfile()];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateProfileViewModel>.reactive(
      builder: (context, model, child) => model.isBusy
          ? Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Center(child: CircularProgressIndicator()),
                  UIText('\nPlease Wait')
                ],
              ),
            )
          : Scaffold(
              backgroundColor: kBackgroundColor,
              appBar: VetAppbar(onSelected: model.openHelpPopup),
              body: ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  isRejected
                      ? Container(
                          height: 60.0,
                          margin: const EdgeInsets.only(bottom: 20.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(
                                color: Color(0xffEECCC4),
                              ),
                              color: const Color(
                                0xffFCEDE9,
                              )),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.warning_amber_rounded,
                                size: 26.0,
                                color: Color(0xffEA4E2C),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 100,
                                child: Text(
                                  model.approvalCommentByAdmin.toString(),
                                  maxLines: 3,
                                  overflow: TextOverflow.fade,
                                  softWrap: true,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  ListTile(
                    title: const UIText.heading(
                      "Create Profile",
                    ),
                    contentPadding: EdgeInsets.zero,
                    subtitle: const UIText(
                        "We need few more details to get started."),
                    trailing: GestureDetector(
                      onTap: () => model.selectProfile(),
                      child: model.profileImage == null
                          ? const CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  AssetImage("assets/images/0.jpg"),
                            )
                          : CircleAvatar(
                              radius: 40,
                              backgroundImage: FileImage(model.profileImage!),
                            ),
                    ),
                  ),
                  verticalSpaceMedium,
                  LazyIndexedStack(
                    itemCount: _views.length,
                    itemBuilder: (BuildContext context, int index) =>
                        _views[index],
                    index: model.currentIndex,
                  )
                ],
              ),
              bottomNavigationBar: Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                height: 110,
                color: kBackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: model.currentIndex != 0,
                      child: TextButton(
                          onPressed: () => model.previous(),
                          child: const Text("Back")),
                    ),
                    ElevatedButton(
                        onPressed: () => model.next(),
                        child:
                            Text(model.currentIndex == 2 ? "Finish" : "Next")),
                  ],
                ),
              ),
            ),
      viewModelBuilder: () => CreateProfileViewModel(),
      onModelReady: (model) => model.onModelReady(),
    );
  }
}
