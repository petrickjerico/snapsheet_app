import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/models/account.dart';
import 'package:snapsheetapp/models/user_data.dart';

class AccountTile extends StatelessWidget {
  AccountTile({this.color, this.title, this.count, this.total});

  Color color;
  String title;
  int count;
  double total;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 0.5,
            color: color,
          ),
        ),
        height: 100.0,
        width: 200.0,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  border: Border.all(
                    width: 0.5,
                    color: color,
                  ),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '$count records',
                          style: TextStyle(color: Colors.white, fontSize: 10.0),
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
            ),
          ],
        ),
      ),
    );
  }
}
