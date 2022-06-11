import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';

class MedicineListItem extends StatelessWidget {
  const MedicineListItem(
      {Key? key, required this.medicine, this.increment, this.decrement})
      : super(key: key);

  final Medicine medicine;
  final VoidCallback? increment;
  final VoidCallback? decrement;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: UIText(
          medicine.name,
          size: TxtSize.Small,
        ),
        subtitle: UIText.paragraph(
          medicine.package,
          color: kTextSecondaryLightColor,
          size: TxtSize.Tiny,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => decrement?.call(),
                icon: Icon(Icons.remove_circle_outline_rounded)),
            horizontalSpaceTiny,
            UIText.label(medicine.quantity.toString()),
            horizontalSpaceTiny,
            IconButton(
                onPressed: () => increment?.call(),
                icon: Icon(Icons.add_circle_outline_rounded)),
          ],
        ),
      ),
    );
  }
}
