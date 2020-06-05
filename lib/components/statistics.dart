import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/models/record.dart';
import 'package:snapsheetapp/models/stats.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:random_color/random_color.dart';

class Statistics extends StatelessWidget {
  final RandomColor _randomColor = RandomColor();
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
      List<charts.Series<Stats, String>> _dataSeries = [];
      List<Record> currRecs = userData.specifiedRecords;

      List<Stats> getStatsList() {
        List<String> categs = userData.categoryTitles;
        List<Stats> res = [];
        for (int catId = 0; catId < categs.length; catId++) {
          String statTitle = categs[catId];
          double statValue = 0;
          for (Record rec in currRecs) {
            if (rec.categoryId == catId) {
              statValue += rec.value;
            }
          }
          if (statValue != 0) {
            res.add(Stats(statTitle, statValue));
          }
        }
        return res;
      }

      var statsList = getStatsList();

      _dataSeries.add(
        charts.Series(
          data: statsList,
          domainFn: (Stats st, _) => st.title,
          measureFn: (Stats st, _) => st.value,
          colorFn: (Stats st, _) => st.color,
          id: userData.selectedAccount == -1
              ? "All Accounts statistics"
              : "Account ${userData.selectedAccount} statistics",
          labelAccessorFn: (Stats st, _) => "${st.value}",
        ),
      );
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Text('Total: ${userData.statsTotal}'),
                  Expanded(
                      child: charts.PieChart(
                    _dataSeries,
                    animate: false,
                    behaviors: [
                      charts.DatumLegend(
                        position: charts.BehaviorPosition.bottom,
                        horizontalFirst: true,
                        desiredMaxColumns: 3,
                        cellPadding: EdgeInsets.only(
                          right: 4.0,
                          bottom: 4.0,
                        ),
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.Color.black, fontSize: 10),
                      )
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
