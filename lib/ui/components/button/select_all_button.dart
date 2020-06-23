import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/models/account.dart';
import 'package:snapsheetapp/models/user_data.dart';

class SelectAllButton extends StatelessWidget {
  const SelectAllButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) => Visibility(
        visible: userData.selectedAccount != -1,
        child: MaterialButton(
          visualDensity: VisualDensity.comfortable,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.blueAccent),
          ),
          child: Text(
            'SELECT ALL',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
          onPressed: () {
            userData.selectAccount(-1);
            for (Account acc in userData.accounts) {
              acc.isSelected = true;
            }
          },
        ),
      ),
    );
  }
}
