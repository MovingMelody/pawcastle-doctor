import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:petdoctor/constants/assets.dart';
import 'package:petdoctor/enums/snackbar_variant.dart';
import 'package:petdoctor/ui/global/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class CallSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const CallSheet({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(kUserAsset),
              ),
              title: Text("Speaking to"),
              subtitle: Text(request.title ?? "S"),
              contentPadding: EdgeInsets.zero,
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              children: [
                ToolbarButton(
                    color: request.data['mute']
                        ? kDoctorColor
                        : Colors.transparent,
                    icon: Icon(
                      Icons.mic_off,
                      color: request.data['mute']
                          ? kTextPrimaryDarkColor
                          : kTextPrimaryLightColor,
                    ),
                    onTap: () => completer(SheetResponse(
                        confirmed: true, data: CallSheetResponse.Mute))),
                ToolbarButton(
                    color: request.data['speaker']
                        ? kDoctorColor
                        : Colors.transparent,
                    icon: Icon(
                      Icons.volume_up,
                      color: request.data['speaker']
                          ? kTextPrimaryDarkColor
                          : kTextPrimaryLightColor,
                    ),
                    onTap: () => completer(SheetResponse(
                        confirmed: true, data: CallSheetResponse.Speaker))),
                Expanded(child: SizedBox()),
                ToolbarButton(
                    color: kErrorColor,
                    icon: Icon(
                      Icons.call_end,
                      color: kTextPrimaryDarkColor,
                      size: 40,
                    ),
                    onTap: () => completer(SheetResponse(
                        confirmed: true, data: CallSheetResponse.End))),
              ],
            ),
            SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
