import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snapsheetapp/components/button/rounded_button.dart';
import 'package:snapsheetapp/config/config.dart';

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
            color: isDelete ? Colors.red : kGrey,
            textColor: kBlack,
            title: 'Delete',
            icon: Icon(
              FontAwesomeIcons.trashAlt,
              color: kBlack,
            ),
            onPressed: isDelete ? () => {} : () => callBack(),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: RoundedButton(
            color: isDelete ? kGrey : Colors.tealAccent,
            textColor: kBlack,
            title: 'Add',
            icon: Icon(
              Icons.done,
              color: kBlack,
            ),
            onPressed: isDelete ? () => callBack() : () => {},
          ),
        ),
      ],
    );
  }
}
