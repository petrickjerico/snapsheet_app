import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/constants.dart';
import 'package:snapsheetapp/models/record.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:intl/intl.dart';

class HistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final record = userData.records[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              child: IconTheme(
                  data: new IconThemeData(color: Colors.white, size: 19),
                  child: record.category.categoryIcon),
            ),
            title: Text(
              record.title,
              style: kHistoryRecordTitle,
            ),
            subtitle: Text("subtitle"),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  record.value.toStringAsFixed(2),
                  style: kHistoryRecordValue,
                ),
                Text(
                  DateFormat('yMd').format(record.date),
                  style: kHistoryRecordDate,
                ),
              ],
            ),
          );
        },
        itemCount: userData.recordsCount,
      );
    });
  }
}
