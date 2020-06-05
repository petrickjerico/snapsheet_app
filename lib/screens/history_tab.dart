import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/constants.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:intl/intl.dart';
import 'package:snapsheetapp/screens/addexpenses_screen.dart';

class HistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
      return Align(
        alignment: Alignment.topCenter,
        child: ListView.builder(
          shrinkWrap: true,
          reverse: true,
          itemBuilder: (context, index) {
            // print(userData.recordsCount);
            final record = userData.allRecords[index];
            return Visibility(
              visible: record.accountId == userData.selectedAccount,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: IconTheme(
                      data: IconThemeData(color: Colors.white, size: 19),
                      child: userData.categoryIcons[record.categoryId]),
                ),
                title: Text(
                  record.title,
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
              ),
            );
          },
          itemCount: userData.recordsCount,
        ),
      );
    });
  }
}
