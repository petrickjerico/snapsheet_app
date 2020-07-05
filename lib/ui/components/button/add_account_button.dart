import 'package:flutter/material.dart';
import 'package:snapsheetapp/ui/config/decoration.dart';
import 'package:snapsheetapp/ui/screens/home/add_account_popup.dart';

class AddAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      visualDensity: VisualDensity.comfortable,
      minWidth: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.add,
            size: 15.0,
            color: Colors.white,
          ),
          SizedBox(
            width: 2.0,
          ),
          Text(
            'ADD',
            style: TextStyle(fontSize: 13.0, color: Colors.white),
          ),
          SizedBox(
            width: 2.0,
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
