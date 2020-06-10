import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/constants.dart';
import 'package:snapsheetapp/models/record.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/addexpenses_screen.dart';

class HistoryTile extends StatelessWidget {
  final Record record;
  final int index;

  HistoryTile({@required this.record, this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          child: IconTheme(
              data: IconThemeData(color: Colors.white, size: 19),
              child: userData.categoryIcons[record.categoryId]),
        ),
        title: Text(
          record.title == ""
              ? userData.categoryTitles[record.categoryId]
              : record.title,
          style: kHistoryRecordTitle,
        ),
        subtitle: Text(userData.accounts[record.accountId]),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              record.value.toStringAsFixed(2),
              style: kHistoryRecordValue,
            ),
            Text(
              DateFormat('d/M/y').format(record.date),
              style: kHistoryRecordDate,
            ),
          ],
        ),
        onTap: () {
          userData.changeTempRecord(index);
          Navigator.pushNamed(context, AddExpensesScreen.id);
        },
      );
    });
  }
}
