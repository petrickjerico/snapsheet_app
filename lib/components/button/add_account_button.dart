import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/home/add_account_popup.dart';

class AddAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) => OutlineButton(
        padding: EdgeInsets.all(8.0),
        borderSide: BorderSide(color: Colors.white),
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
              'ADD ACCOUNT',
              style: TextStyle(fontSize: 13.0, color: Colors.white),
            ),
            SizedBox(
              width: 2.0,
            ),
          ],
        ),
        textColor: Colors.black,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddAccountPopup(),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
          );
        },
      ),
    );
  }
}
