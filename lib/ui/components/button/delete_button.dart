import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snapsheetapp/ui/components/button/rounded_button.dart';
import 'package:snapsheetapp/ui/config/config.dart';

class DeleteConfirmButton extends StatelessWidget {
  final bool isDelete;
  final Function callBack;

  DeleteConfirmButton({this.isDelete, this.callBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RoundedButton(
            color: isDelete ? Colors.red.withOpacity(0.3) : kGrey,
            textColor: isDelete ? Colors.red : kScaffoldBackgroundColour,
            title: 'Delete',
            icon: Icon(
              FontAwesomeIcons.trashAlt,
              color: isDelete ? Colors.red : kScaffoldBackgroundColour,
            ),
            onPressed: isDelete ? () => {} : () => callBack(),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: RoundedButton(
            color: isDelete ? kGrey : Colors.tealAccent.withOpacity(0.3),
            textColor: isDelete ? kScaffoldBackgroundColour : Colors.tealAccent,
            title: 'Add',
            icon: Icon(
              Icons.done,
              color: isDelete ? kScaffoldBackgroundColour : Colors.tealAccent,
            ),
            onPressed: isDelete ? () => callBack() : () => {},
          ),
        ),
      ],
    );
  }
}
