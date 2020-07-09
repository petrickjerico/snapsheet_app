import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/homepage_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/ui/components/stats/stats_card.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/screens/expense/expense_screen.dart';
import '../history_tile.dart';
import 'empty_stats.dart';
import 'indicator.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageViewModel>(builder: (context, model, child) {
      if (model.selectedAccountIsEmpty()) {
        return EmptyStats();
      } else {
        Color _contentColor = Colors.white54;
        return ListView(
          children: <Widget>[
            Visibility(
              visible: model.selectedAccountHasIncome(),
              child: StatsCard(
                  title: 'Balance',
                  colour: _contentColor,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Total Expense',
                            style: TextStyle(color: _contentColor),
                          ),
                          Text(
                            "-" +
                                model
                                    .statsGetBalanceData()[1]
                                    .toStringAsFixed(2),
                            style: kHistoryExpenseValue,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Total Income',
                            style: TextStyle(color: _contentColor),
                          ),
                          Text(
                            model.statsGetBalanceData()[0].toStringAsFixed(2),
                            style: kHistoryIncomeValue,
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Balance Amount',
                            style: TextStyle(color: _contentColor),
                          ),
                          Text(
                            model.statsGetBalanceData()[2].toStringAsFixed(2),
                            style: model.statsGetBalanceData()[2] < 0
                                ? kHistoryExpenseValue
                                : kHistoryIncomeValue,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Income',
                            style:
                                TextStyle(color: _contentColor, fontSize: 10.0),
                          ),
                          Text(
                            'Expense',
                            style:
                                TextStyle(color: _contentColor, fontSize: 10.0),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green[600],
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  bottomLeft: Radius.circular(5.0),
                                ),
                              ),
                              alignment: AlignmentDirectional.centerStart,
                              height: 25,
                            ),
                            flex: model.statsGetBalanceData()[0].round(),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red[600],
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5.0),
                                ),
                              ),
                              alignment: AlignmentDirectional.centerEnd,
                              height: 25,
                            ),
                            flex: model.statsGetBalanceData()[1].round(),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            StatsCard(
              title: 'Expenses Breakdown',
              colour: _contentColor,
              child: AspectRatio(
                aspectRatio: 1.3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          'Total: \$${model.currentExpensesTotal().toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 25,
                              color: _contentColor.withOpacity(0.3),
                              fontWeight: FontWeight.w400)),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          PieChart(
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
                        ],
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
                            textColor: _contentColor,
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
            ),
            StatsCard(
              title: 'Recent Records',
              colour: _contentColor,
              child: Align(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final record = model.getTop5Records()[index];
                    return HistoryTile(
                      record: record,
                      index: model.records.indexOf(record),
                      color: _contentColor,
                    );
                  },
                  itemCount: model.getTop5Records().length,
                ),
              ),
            ),
          ],
        );
      }
    });
  }
}
