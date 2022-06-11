import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/enums/snackbar_variant.dart';
import 'package:petdoctor/ui/global/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void _setupSnackbarConfig() {
  final _snackbarService = locator<SnackbarService>();

  _snackbarService.registerSnackbarConfig(SnackbarConfig(
      backgroundColor: kTextPrimaryLightColor,
      titleColor: kTextPrimaryDarkColor,
      borderRadius: 6,
      messageColor: Colors.white54));

  _snackbarService.registerCustomSnackbarConfig(
      variant: SnackbarType.Error,
      config: SnackbarConfig(
          backgroundColor: kErrorColor,
          titleColor: kTextPrimaryDarkColor,
          borderRadius: 6,
          messageColor: Colors.white54));
}

void _setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    SheetType.Call: (context, sheetRequest, completer) =>
        CallSheet(request: sheetRequest, completer: completer)
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}

void setupStacked() {
  _setupBottomSheetUi();
  _setupSnackbarConfig();
}
