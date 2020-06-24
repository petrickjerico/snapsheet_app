import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/dashboard_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/ui/screens/expense/expense_screen.dart';
import '../history_tile.dart';
import 'indicator.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (context, model, child) {
        print('Before model.selectedAccountIsEmpty()');
        if (model.selectedAccountIsEmpty()) {
          print('After model.selectedAccountIsEmpty()');

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Icon(
                  Icons.add_circle,
                  color: Colors.white24,
                  size: 120.0,
                ),
                onTap: () {
                  ExpenseViewModel expenseModel =
                      Provider.of<ExpenseViewModel>(context);
                  expenseModel.newRecord();
                  Navigator.pushNamed(context, ExpenseScreen.id);
                },
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'No records found for this account yet.\nTap to create one.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white30, fontSize: 15),
                ),
              )
            ],
          );
        }

        return ListView(
          children: <Widget>[
            Visibility(
              visible: model.selectedAccountHasIncome(),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Balance',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                                'Balance: \$${model.statsGetBalanceData()[2].toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Income',
                                        style: TextStyle(fontSize: 12.0)),
                                    Text('Expense',
                                        style: TextStyle(fontSize: 12.0)),
                                  ],
                                ),
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.green[600],
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5.0),
                                                bottomLeft:
                                                    Radius.circular(5.0),
                                              ),
                                            ),
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            height: 25,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 5.0),
                                              child: Text(
                                                model
                                                    .statsGetBalanceData()[0]
                                                    .toStringAsFixed(2),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          flex: model
                                              .statsGetBalanceData()[0]
                                              .round(),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red[600],
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5.0),
                                                bottomRight:
                                                    Radius.circular(5.0),
                                              ),
                                            ),
                                            alignment:
                                                AlignmentDirectional.centerEnd,
                                            height: 25,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5.0),
                                              child: Text(
                                                model
                                                    .statsGetBalanceData()[1]
                                                    .toStringAsFixed(2),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          flex: model
                                              .statsGetBalanceData()[1]
                                              .round(),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      color: Colors.black.withOpacity(0.6),
                                      height: 30,
                                      width: 2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 1.05,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Expenses Breakdown',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            'Total: \$${model.currentExpensesTotal().toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600)),
                      ),
                      Expanded(
                        child: PieChart(
                          PieChartData(
                              pieTouchData: PieTouchData(
                                  touchCallback: (pieTouchResponse) {
                                if (pieTouchResponse.touchedSectionIndex !=
                                    null) {
                                  setState(() {
                                    model.updateTouchedIndex(
                                        pieTouchResponse.touchedSectionIndex);
                                  });
                                }
                              }),
                              startDegreeOffset: -90,
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 2,
                              centerSpaceRadius: 60,
                              sections: model.showingCategorySections()),
                          swapAnimationDuration: Duration(seconds: 0),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        children: categories
                            .where((category) =>
                                model.getCategoryTotal(
                                    categories.indexOf(category)) >
                                0)
                            .map(
                          (category) {
                            return Indicator(
                              color: category.color,
                              text: category.title,
                              isSquare: false,
                              size: 6,
                              textColor: Colors.black87,
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Recent Records',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 4.0, right: 8.0, bottom: 15.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final record = model.getTop5Records()[index];
                          return Visibility(
                            visible:
                                record.uid == model.getSelectedAccountUid() ||
                                    model.selectedAccountIndex == -1,
                            child: HistoryTile(
                                record: record,
                                index: model.records.indexOf(record)),
                          );
                        },
                        itemCount: model.getTop5Records().length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
