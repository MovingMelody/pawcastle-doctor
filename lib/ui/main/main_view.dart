import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/ui/global/iconpack.dart';
import 'package:petdoctor/ui/global/lazy_indexed_stack.dart';
import 'package:petdoctor/ui/home/home_view.dart';
import 'package:petdoctor/ui/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'main_viewmodel.dart';

class MainView extends StatelessWidget {
  MainView({Key? key}) : super(key: key);

  final _views = [
    HomeView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      builder: (context, model, child) => WillPopScope(
        onWillPop: () => model.showExitDialog(),
        child: Scaffold(
          body: LazyIndexedStack(
            reuse: true,
            index: model.currentIndex,
            itemCount: _views.length,
            itemBuilder: (_, index) => _views[index],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: kBackgroundColor,
            currentIndex: model.currentIndex,
            onTap: model.setIndex,
            items: const [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(IconPack.home),
              ),
              
              BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(IconPack.person),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => MainViewModel(),
    );
  }
}
