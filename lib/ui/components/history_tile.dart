import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/screens/screens.dart';

class HistoryTile extends StatelessWidget {
  final Record record;
  final int index;

  HistoryTile({@required this.record, this.index});

  @override
  Widget build(BuildContext context) {
    print("BEFORE CONSUMER");
    return Consumer<ExpenseViewModel>(builder: (context, model, child) {
      Category category = categories[record.categoryId];
      print("BEFORE LIST TILE");
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
        subtitle: Text(model.userData.getThisAccount(record.accountUid).title),
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
              DateFormat('d/M/y').format(record.dateTime),
              style: kHistoryRecordDate,
            ),
          ],
        ),
        onTap: () {
          model.changeTempRecord(index);
          Navigator.pushNamed(context, ExpenseScreen.id);
        },
      );
    });
  }
}
