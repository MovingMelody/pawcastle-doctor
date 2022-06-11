import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final String title;
  final String value;
  final List<String> listItems;
  final Function onChanged;
  const DropdownWidget(
      {Key? key,
      required this.listItems,
      required this.title,
      required this.value,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIText.paragraph(title),
        verticalSpaceTiny,
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(
                5,
              )),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          margin: EdgeInsets.only(bottom: 12.0),
          child: DropdownButton<String>(
            underline: Container(),
            isExpanded: true,
            hint: Text(value),
            items: listItems.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: UIText.paragraph(value),
              );
            }).toList(),
            onChanged: (value) => onChanged(value ?? ""),
          ),
        ),
      ],
    );
  }
}
