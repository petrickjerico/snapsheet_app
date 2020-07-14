import 'package:flutter/material.dart';
import 'package:snapsheetapp/ui/components/account/accounts_carousel.dart';
import 'package:snapsheetapp/ui/components/stats/statistics.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AccountsCarousel(),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Statistics(),
          ),
        ),
      ],
    );
  }
}
