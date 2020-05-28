import 'package:flutter/material.dart';
import 'package:snapsheetapp/components/homepage_card.dart';

class AccountsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: HomepageCard(
              cardChild: Text(
                'List of accounts goes here.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: HomepageCard(
              cardChild: Text(
                'Visuals for accounts go here.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
