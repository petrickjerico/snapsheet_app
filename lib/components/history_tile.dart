import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/config/config.dart';
import 'package:snapsheetapp/models/category.dart';
import 'package:snapsheetapp/models/record.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/calculator/addexpenses_screen.dart';

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
          backgroundColor: category.color.withOpacity(0.2),
          child: IconTheme(
            data: IconThemeData(color: category.color, size: 17),
            child: FaIcon(category.icon.icon),
          ),
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
              style:
                  record.isIncome ? kHistoryIncomeValue : kHistoryExpenseValue,
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
