import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/homepage_card.dart';
import 'package:snapsheetapp/main.dart';
import 'package:snapsheetapp/models/category.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:random_color/random_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:snapsheetapp/screens/calculator/addexpenses_screen.dart';
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

        if (!userData.records.any((rec) => rec.accountId == selectedAccount) &&
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
//            HomepageCard(
//              cardChild: Container(
//                height: 250,
//                child: Padding(
//                  padding: const EdgeInsets.all(20.0),
//                  child: Column(
//                    mainAxisSize: MainAxisSize.min,
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Flexible(
//                        child: Text('Total: ${userData.statsTotal}'),
//                        fit: FlexFit.loose,
//                      ),
//                      Flexible(
//                        fit: FlexFit.loose,
//                        child: Text(
//                          'Account: ${userData.selectedAccount == -1 ? "all" : userData.accounts[userData.selectedAccount].title} \n\n'
//                          'Height Test for scrollable.',
//                          textAlign: TextAlign.center,
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ),
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
            HomepageCard(
              cardChild: Column(
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
                            visible:
                                record.accountId == userData.selectedAccount ||
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
//            HomepageCard(
//              cardChild: Container(
//                height: 250,
//              ),
//            ),
          ],
        );
      },
    );
  }
}
