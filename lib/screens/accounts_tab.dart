import 'package:flutter/material.dart';
import 'package:snapsheetapp/components/homepage_card.dart';

class AccountsTab extends StatefulWidget {
  @override
  _AccountsTabState createState() => _AccountsTabState();
}

class _AccountsTabState extends State<AccountsTab> {
  String currentSelection;

  Widget buildButton(String str) {
    return OutlineButton(
      color: Colors.blueGrey,
      focusColor: Colors.blueGrey,
      child: Text(str),
      onPressed: () {
        setState(() {
          currentSelection = str;
        });
      },
    );
  }

  Widget makeAccountButtons() {
    return GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children:
            List.generate(6, (index) => buildButton('Account ${index + 1}')));
  }

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
            child: HomepageCard(cardChild: makeAccountButtons()),
          ),
          Expanded(
            flex: 8,
            child: HomepageCard(
              cardChild: Text(
                '$currentSelection selected for viewing.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
