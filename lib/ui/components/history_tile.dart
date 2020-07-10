import 'package:animations/animations.dart';
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
  final Color color;

  HistoryTile({@required this.record, this.index, this.color});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseViewModel>(builder: (context, model, child) {
      Category category = categories[record.categoryId];
      return OpenContainer<bool>(
        closedBuilder: (_, openContainer) {
          return ListTile(
            contentPadding: EdgeInsets.all(0),
            dense: true,
            leading: CircleAvatar(
              backgroundColor: category.color.withOpacity(0.2),
              child: IconTheme(
                data: IconThemeData(color: category.color, size: 15),
                child: FaIcon(category.icon.icon),
              ),
            ),
            title: Text(
              record.title == "" ? category.title : record.title,
              style: kHistoryRecordTitle.copyWith(
                  color: color ?? Colors.black, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              model.userData.getThisAccount(record.accountUid).title,
              style: kHistoryRecordTitle.copyWith(
                  color: color?.withOpacity(0.3) ?? Colors.black,
                  fontWeight: FontWeight.normal),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  record.value.toStringAsFixed(2),
                  style: record.isIncome
                      ? kHistoryIncomeValue
                      : kHistoryExpenseValue,
                ),
                Text(
                  DateFormat('d/M/y').format(record.dateTime),
                  style:
                      kHistoryRecordDate.copyWith(color: color ?? Colors.black),
                ),
              ],
            ),
            onTap: () {
              model.changeTempRecord(index);
              openContainer.call();
            },
          );
        },
        openBuilder: (_, openContainer) {
          return ExpenseScreen();
        },
        closedElevation: 0,
        closedColor: Colors.transparent,
        transitionType: ContainerTransitionType.fade,
      );
    });
  }
}
