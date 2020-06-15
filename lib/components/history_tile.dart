import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'file:///C:/Users/jtedd/AndroidStudioProjects/snapsheet_app/lib/shared/constants.dart';
import 'package:snapsheetapp/models/category.dart';
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
      Category category = userData.categories[record.categoryId];
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: category.color,
          child: IconTheme(
              data: IconThemeData(color: Colors.white, size: 17),
              child: category.icon),
        ),
        title: Text(
          record.title == "" ? category.title : record.title,
          style: kHistoryRecordTitle,
        ),
        subtitle: Text(userData.accounts[record.accountId].title),
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
