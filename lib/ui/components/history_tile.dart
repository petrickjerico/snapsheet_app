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

class HistoryTile extends StatefulWidget {
  final Record record;
  final int index;
  final Color color;

  HistoryTile({@required this.record, this.index, this.color});
  HistoryTile.from(HistoryTile other)
      : record = other.record,
        index = other.index,
        color = other.color;

  @override
  _HistoryTileState createState() => _HistoryTileState();
}

class _HistoryTileState extends State<HistoryTile> {
  @override
  Widget build(BuildContext context) {
    bool isAlreadyAdded = false;
    return Consumer<ExpenseViewModel>(builder: (context, model, child) {
      Category category = categories[widget.record.categoryId];
      return OpenContainer<bool>(
        closedBuilder: (_, openContainer) {
          return Dismissible(
            background: Container(
              color: Colors.black38,
              padding: EdgeInsets.only(left: 15.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.delete,
                    color: Colors.white54,
                  ),
                ],
              ),
              alignment: Alignment.centerLeft,
            ),
            secondaryBackground: Container(
              color: Colors.black38,
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.delete,
                color: Colors.white54,
              ),
              alignment: Alignment.centerRight,
            ),
            key: Key(widget.record.uid),
            onDismissed: (direction) {
              final homepageModel =
                  Provider.of<HomepageViewModel>(context, listen: false);
              model.changeTempRecord(widget.index);
              model.deleteRecord();
              homepageModel
                  .selectAccount(model.getAccountIndexFromTempRecord());
              HomepageViewModel.syncController();
              Flushbar(
                mainButton: FlatButton(
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
                widget.record.title == ""
                    ? category.title
                    : widget.record.title,
                style: kHistoryRecordTitle.copyWith(
                    color: widget.color ?? Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                model.userData.getThisAccount(widget.record.accountUid).title,
                style: kHistoryRecordTitle.copyWith(
                    color: widget.color?.withOpacity(0.5) ?? Colors.white,
                    fontWeight: FontWeight.normal),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    widget.record.value.toStringAsFixed(2),
                    style: widget.record.isIncome
                        ? kHistoryIncomeValue
                        : kHistoryExpenseValue,
                  ),
                  Text(
                    DateFormat('d/M/y').format(widget.record.dateTime),
                    style: kHistoryRecordDate.copyWith(
                        color: widget.color ?? Colors.black),
                  ),
                ],
              ),
              onTap: () {
                model.changeTempRecord(widget.index);
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
