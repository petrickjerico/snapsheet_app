import 'package:flutter/material.dart';
import 'package:snapsheetapp/ui/config/colors.dart';
import 'package:snapsheetapp/ui/config/decoration.dart';
import 'package:snapsheetapp/ui/screens/home/add_account_popup.dart';

class AddAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.all(0),
      color: kNavyBlue,
      minWidth: 100,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      textColor: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.add,
            size: 17.0,
          ),
          Text(
            'ADD',
          ),
        ],
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: AddAccountPopup(),
          ),
          shape: kBottomSheetShape,
        );
      },
    );
  }
}
