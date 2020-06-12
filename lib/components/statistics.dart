import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/homepage_card.dart';
import 'package:snapsheetapp/models/record.dart';
import 'package:snapsheetapp/models/stats.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:random_color/random_color.dart';

class Statistics extends StatelessWidget {
  final RandomColor _randomColor = RandomColor();
  @override
  Widget build(BuildContext context) {
    return HomepageCard(
      cardChild: Consumer<UserData>(builder: (context, userData, child) {
        List<charts.Series<Stats, String>> _dataSeries = [];
        List<Record> currRecs = userData.specifiedRecords;

        List<Stats> getStatsList() {
          List<String> categoryTitles =
              userData.categories.map((e) => e.title).toList();
          List<Stats> res = [];
          for (int catId = 0; catId < categoryTitles.length; catId++) {
            String statTitle = categoryTitles[catId];
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
        return Container(
          height: 700,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Text('Total: ${userData.statsTotal}'),
                  fit: FlexFit.loose,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    'Account: ${userData.selectedAccount == -1 ? "all" : userData.accounts[userData.selectedAccount].title} \n\n'
                    'Height Test for scrollable.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
