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
