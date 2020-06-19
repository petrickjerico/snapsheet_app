import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/models/account.dart';
import 'package:snapsheetapp/models/user_data.dart';

class AccountTile extends StatelessWidget {
  AccountTile({this.index, this.color, this.title, this.count, this.total});

  int index;
  Color color;
  String title;
  int count;
  double total;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) => GestureDetector(
        onTap: () {
          if (userData.selectedAccount != index) {
            userData.selectAccount(index);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 50.0,
          width: 100.0,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  total.toStringAsFixed(2),
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
