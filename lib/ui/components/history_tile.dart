import 'package:animations/animations.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/screens/screens.dart';

class HistoryTile extends StatelessWidget {
  final Record record;
  final int index;
  final Color color;
  final bool fromHistory;

  HistoryTile(
      {@required this.record,
      this.index,
      this.color,
      this.fromHistory = false});
  HistoryTile.from(HistoryTile other)
      : record = other.record,
        index = other.index,
        color = other.color,
        fromHistory = other.fromHistory;

  @override
  Widget build(BuildContext context) {
    bool isAlreadyAdded = false;
    return Consumer<ExpenseViewModel>(builder: (context, model, child) {
      Category category = model.userData.getThisCategory(record.categoryUid);
      return OpenContainer<bool>(
        closedBuilder: (_, openContainer) {
          return Dismissible(
            background: Container(
              color: Colors.redAccent.withOpacity(0.2),
              padding: EdgeInsets.only(left: 15.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                ],
              ),
              alignment: Alignment.centerLeft,
            ),
            secondaryBackground: Container(
              color: Colors.redAccent.withOpacity(0.2),
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              alignment: Alignment.centerRight,
            ),
            key: Key(record.uid),
            onDismissed: (direction) {
              final homepageModel =
                  Provider.of<HomepageViewModel>(context, listen: false);
              model.changeTempRecord(index);
              model.deleteRecord();
              homepageModel
                  .selectAccount(model.getAccountIndexFromTempRecord());
              HomepageViewModel.syncController();
              if (fromHistory) {
                final filterData =
                    Provider.of<FilterData>(context, listen: false);
                filterData.deleteRecord(record);
              }
              Flushbar(
                mainButton: FlatButton(
                  disabledColor: Colors.grey,
                  child: Text(
                    'UNDO',
                    style: TextStyle(color: kDarkCyan),
                  ),
                  onPressed: () {
                    if (!isAlreadyAdded) {
                      model.addRecord();
                      homepageModel
                          .selectAccount(model.getAccountIndexFromTempRecord());
                      HomepageViewModel.syncController();
                      isAlreadyAdded = true;
                      if (fromHistory) {
                        final filterData =
                            Provider.of<FilterData>(context, listen: false);
                        filterData.undoDelete();
                      }
                    } else {
                      return;
                    }
                  },
                ),
                message: "Record successfully deleted.",
                icon: Icon(
                  Icons.info_outline,
                  size: 28.0,
                  color: Colors.blue[300],
                ),
                duration: Duration(seconds: 3),
                leftBarIndicatorColor: Colors.blue[300],
              )..show(context);
            },
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
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
                style: Theme.of(context).textTheme.bodyText1,
              ),
              subtitle: Text(
                model.userData.getThisAccount(record.accountUid).title,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              trailing: Container(
                width: 125,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    record.receiptURL != null
                        ? IconButton(
                            icon: Icon(Icons.receipt),
                            onPressed: () {
                              model.changeTempRecord(index);
                              Navigator.pushNamed(
                                  context, EditExpenseInfoScreen.id);
                            },
                          )
                        : SizedBox.shrink(),
                    SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          (record.isIncome ? "" : "-") +
                              record.value.toStringAsFixed(2),
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: record.isIncome
                                  ? Colors.green
                                  : Colors.redAccent),
                        ),
                        Text(
                          DateFormat('d/M/y').format(record.dateTime),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {
                model.changeTempRecord(index);
                openContainer.call();
              },
            ),
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
