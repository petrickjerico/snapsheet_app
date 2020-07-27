import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/models/account.dart';
import 'package:snapsheetapp/business_logic/models/record.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/ui/components/stats/stats_card.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/screens/expense/expense_screen.dart';
import 'package:snapsheetapp/ui/screens/home/history_screen.dart';
import 'package:sorted_list/sorted_list.dart';
import '../history_tile.dart';
import '../empty_state.dart';
import 'indicator.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  static final ScrollController _scrollController = ScrollController();
  final _balanceKey = GlobalKey();
  final _expensesBreakdownKey = GlobalKey();
  final _amountTrendKey = GlobalKey();
  final _recentRecordsKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageViewModel>(
      builder: (context, model, child) {
        if (model.selectedAccountIsEmpty()) {
          return EmptyState(
            onTap: () {
              final expenseModel =
                  Provider.of<ExpenseViewModel>(context, listen: false);
              expenseModel.newRecord();
              expenseModel.changeAccount(model.getSelectedAccount().index);
              Navigator.pushNamed(context, ExpenseScreen.id);
            },
            messageColor: Colors.grey,
            message: 'No records found for this account yet.\n'
                'Tap to create one.',
            icon: Icon(
              Icons.add_circle,
              color: Colors.grey,
              size: 120.0,
            ),
          );
        } else {
          SchedulerBinding.instance.addPostFrameCallback(
            (_) => _scrollController.animateTo(
              0,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
            ),
          );
          Color _contentColor = kStatsFontColour;
          final _showBalance =
              model.selectedAccountHasIncome() && model.balanceCustom;
          final _showExpensesBreakdown =
              model.selectedAccountHasExpense() && model.expenseBreakdownCustom;
          final _showTrend = model.amountTrendCustom;
          final _showRecents = true;

          Widget _makeDirectoryButton(
            String title,
            bool enabled,
            GlobalKey key,
          ) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 3,
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  disabledColor: Colors.grey.withOpacity(0.5),
                  minWidth: 0,
                  splashColor: null,
                  color: Colors.white,
                  child: Text(title),
                  textColor: _contentColor,
                  disabledTextColor: _contentColor.withOpacity(0.3),
                  onPressed: enabled
                      ? () => Scrollable.ensureVisible(key.currentContext)
                      : null),
            );
          }

          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _makeDirectoryButton(
                              'Balance', _showBalance, _balanceKey),
                          _makeDirectoryButton('Expenses Breakdown',
                              _showExpensesBreakdown, _expensesBreakdownKey),
                          _makeDirectoryButton(
                              'Amount Trend', _showTrend, _amountTrendKey),
                          _makeDirectoryButton('Recent Records', _showRecents,
                              _recentRecordsKey),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Expanded(
                flex: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    controller: _scrollController,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Visibility(
                          key: _balanceKey,
                          visible: _showBalance,
                          child: StatsCard(
                            title: 'Balance',
                            colour: _contentColor,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Total Expense',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Total Income',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    Text(
                                      model
                                          .statsGetBalanceData()[0]
                                          .toStringAsFixed(2),
                                      style: kHistoryIncomeValue,
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Balance Amount',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      model
                                          .statsGetBalanceData()[2]
                                          .toStringAsFixed(2),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Income',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                    Text(
                                      'Expense',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          color: Colors.green[600],
                                          height: 25,
                                        ),
                                        flex: model
                                            .statsGetBalanceData()[0]
                                            .round(),
                                      ),
                                      Expanded(
                                        child: Container(
                                          color: Colors.red[600],
                                          height: 25,
                                        ),
                                        flex: model
                                            .statsGetBalanceData()[1]
                                            .round(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          key: _expensesBreakdownKey,
                          visible: _showExpensesBreakdown,
                          child: StatsCard(
                            title: 'Expenses Breakdown',
                            colour: _contentColor,
                            child: AspectRatio(
                              aspectRatio: 1.3,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Total: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: model
                                                .currentExpensesTotal()
                                                .toStringAsFixed(2),
                                            style: kHistoryExpenseValue,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        PieChart(
                                          PieChartData(
                                              pieTouchData: PieTouchData(
                                                  touchCallback:
                                                      (pieTouchResponse) {
                                                if (pieTouchResponse
                                                        .touchedSectionIndex !=
                                                    null) {
                                                  setState(() {
                                                    model.updateDonutTouchedIndex(
                                                        pieTouchResponse
                                                            .touchedSectionIndex);
                                                  });
                                                }
                                              }),
                                              startDegreeOffset: -90,
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              sectionsSpace: 2,
                                              centerSpaceRadius: 60,
                                              sections: model
                                                  .showingCategorySections()),
                                          swapAnimationDuration:
                                              Duration(seconds: 0),
                                        ),
                                        Visibility(
                                          visible: defaultCategories
                                                      .where((category) =>
                                                          model.getCategoryTotal(
                                                              defaultCategories
                                                                  .indexOf(
                                                                      category)) >
                                                          0)
                                                      .length >
                                                  1 &&
                                              model.donutTouchedIndex == null,
                                          child: Center(
                                            child: Text(
                                              'Tap section for details.',
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 10,
                                                color: _contentColor,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Wrap(
                                    direction: Axis.horizontal,
                                    alignment: WrapAlignment.center,
                                    children: defaultCategories
                                        .where((category) =>
                                            model.getCategoryTotal(
                                                defaultCategories
                                                    .indexOf(category)) >
                                            0)
                                        .map(
                                      (category) {
                                        return Indicator(
                                          color: category.color,
                                          text: category.title,
                                          isSquare: false,
                                          size: 10,
                                          textColor: _contentColor,
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _showTrend,
                          child: StatsCard(
                            key: _amountTrendKey,
                            title: 'Amount Trend',
                            colour: _contentColor,
                            child: Column(
                              children: <Widget>[
                                AspectRatio(
                                  aspectRatio: 1.5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(18)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 20, top: 40, bottom: 10),
                                      child: LineChart(
                                        LineChartData(
                                          lineTouchData: LineTouchData(
                                            touchTooltipData:
                                                LineTouchTooltipData(
                                              tooltipBgColor:
                                                  Colors.white.withOpacity(0.3),
                                            ),
                                            touchCallback: (LineTouchResponse
                                                touchResponse) {},
                                            handleBuiltInTouches: true,
                                          ),
                                          gridData: FlGridData(
                                            verticalInterval:
                                                model.getLimits()[5],
                                            horizontalInterval:
                                                model.getLimits()[4],
                                            show: true,
                                          ),
                                          titlesData: FlTitlesData(
                                            bottomTitles: SideTitles(
                                              showTitles: true,
                                              reservedSize: 22,
                                              textStyle: TextStyle(
                                                color: _contentColor,
                                                fontSize: 12,
                                              ),
                                              margin: 10,
                                              interval: model.getLimits()[5],
                                              getTitles: (value) {
                                                var date = DateTime.now().add(
                                                    Duration(
                                                        days: value.toInt()));
                                                return '${date.day}/${date.month}';
                                              },
                                            ),
                                            leftTitles: SideTitles(
                                              showTitles: true,
                                              textStyle: TextStyle(
                                                color: _contentColor,
                                                fontSize: 12,
                                              ),
                                              interval: model.getLimits()[4],
                                              margin: 8,
                                              reservedSize: 30,
                                            ),
                                          ),
                                          borderData: FlBorderData(
                                            show: true,
                                            border: Border(
                                              bottom: BorderSide(
                                                color: _contentColor,
                                                width: 2,
                                              ),
                                              left: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                              right: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                              top: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                          minX: model.getLimits()[0],
                                          maxX: model.getLimits()[1],
                                          minY: model.getLimits()[2],
                                          maxY: model.getLimits()[3],
                                          lineBarsData: model.linesBarData1(),
                                        ),
                                        swapAnimationDuration:
                                            Duration(milliseconds: 250),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Tap and hold to see the balance at that time.',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 10,
                                    color: _contentColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        StatsCard(
                          key: _recentRecordsKey,
                          title: 'Recent Records',
                          colour: _contentColor,
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topCenter,
                                child: ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final record =
                                        model.getTop5Records()[index];
                                    return HistoryTile(
                                      record: record,
                                      index: model.records.indexOf(record),
                                      color: _contentColor,
                                    );
                                  },
                                  itemCount: model.getTop5Records().length,
                                ),
                              ),
                              Consumer<FilterData>(
                                builder: (context, filterData, child) {
                                  return Visibility(
                                    visible: model
                                            .getRecordsFromCurrentAccount()
                                            .length >
                                        5,
                                    child: FlatButton(
                                      visualDensity: VisualDensity.compact,
                                      child: Text(
                                        'SEE MORE',
                                        style: TextStyle(color: kDarkCyan),
                                      ),
                                      onPressed: () {
                                        final homepageModel =
                                            Provider.of<HomepageViewModel>(
                                                context,
                                                listen: false);
                                        Account selected =
                                            homepageModel.getSelectedAccount();
                                        if (selected != null) {
                                          filterData.accountsToMatch.clear();
                                          filterData.accountsToMatch.add(
                                              homepageModel
                                                  .getSelectedAccount());
                                          filterData.toggleActivity(true);
                                        }
                                        homepageModel.syncBarToPage(1);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 70.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
