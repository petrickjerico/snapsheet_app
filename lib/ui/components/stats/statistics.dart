import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/homepage_card.dart';
import 'package:snapsheetapp/main.dart';
import 'package:snapsheetapp/models/category.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:random_color/random_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:snapsheetapp/screens/calculator/expense_screen.dart';
import '../history_tile.dart';
import 'indicator.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final RandomColor _randomColor = RandomColor();
  int selectedAccount;
  int touchedIndex;
  bool isTouched = false;
  void updateTouchedIndex(int i) {
    print("input is: $i");
    if (touchedIndex == i) {
      touchedIndex = null;
    } else {
      touchedIndex = i;
    }
  }

  @override
  void initState() {
    super.initState();
    selectedAccount = -1;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var userData = Provider.of<UserData>(context);
    if (selectedAccount != userData.selectedAccount) {
      selectedAccount = userData.selectedAccount;
      touchedIndex = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) {
        List<Category> cats = userData.categories;
        List<PieChartSectionData> showingCategorySections() {
          return List.generate(
            cats.length,
            (i) {
              final Category cat = cats[i];
              final bool isTouched = i == touchedIndex;
              final bool isIncome = cat.isIncome;
              final double opacity = isTouched ? 1 : 0.4;
              final value = userData.statsGetCategTotalFromCurrent(i);
              switch (i) {
                default:
                  return PieChartSectionData(
                    color: cat.color.withOpacity(opacity),
                    value: isIncome ? 0 : value,
                    showTitle: isTouched && value > 0 && !isIncome,
                    title: '${cat.title} \n ${value.toStringAsFixed(2)}',
                    radius: isTouched ? 40 : 30,
                    titleStyle: TextStyle(
                        fontSize: 15, color: Colors.black.withOpacity(0.8)),
                    titlePositionPercentageOffset: -1.5,
                  );
              }
            },
          );
        }

        if (!userData.records.any((rec) => rec.id == selectedAccount) &&
            userData.selectedAccount != -1) {
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
                  userData.newRecord();
                  Navigator.pushNamed(context, AddExpensesScreen.id);
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
              visible: userData.hasIncome(userData.selectedAccount),
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
                                'Balance: \$${userData.statsGetBalanceData()[2].toStringAsFixed(2)}',
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
                                                userData
                                                    .statsGetBalanceData()[0]
                                                    .toStringAsFixed(2),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          flex: userData
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
                                                userData
                                                    .statsGetBalanceData()[1]
                                                    .toStringAsFixed(2),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          flex: userData
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
                            'Total: \$${userData.currentExpensesTotal.toStringAsFixed(2)}',
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
                                    updateTouchedIndex(
                                        pieTouchResponse.touchedSectionIndex);
                                  });
                                  print(touchedIndex);
                                }
                              }),
                              startDegreeOffset: -90,
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 2,
                              centerSpaceRadius: 60,
                              sections: showingCategorySections()),
                          swapAnimationDuration: Duration(seconds: 0),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        children: cats
                            .where((e) =>
                                userData.statsGetCategTotalFromCurrent(
                                    cats.indexOf(e)) >
                                0)
                            .toList()
                            .map(
                          (e) {
                            double value = userData
                                .statsGetCategTotalFromCurrent(cats.indexOf(e));
                            return Indicator(
                              color: e.color,
                              text: e.title,
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
                          // print(userData.recordsCount);
                          final record = userData.statsGetRecords(4)[index];
                          return Visibility(
                            visible: record.id == userData.selectedAccount ||
                                userData.selectedAccount == -1,
                            child: HistoryTile(
                                record: record,
                                index: userData.records.indexOf(record)),
                          );
                        },
                        itemCount: userData.statsGetRecords(4).length,
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
