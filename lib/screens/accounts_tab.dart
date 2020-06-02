import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/homepage_card.dart';
import 'package:snapsheetapp/models/account.dart';
import 'package:snapsheetapp/models/accounts_data.dart';

class AccountsTab extends StatefulWidget {
  @override
  _AccountsTabState createState() => _AccountsTabState();
}

class _AccountsTabState extends State<AccountsTab> {
  Account currentSelection;

  Widget buildButton(Account acc) {
    return OutlineButton(
      child: Text(acc.title),
      onPressed: () {
        setState(() {
          currentSelection = acc;
        });
      },
    );
  }

  Widget makeAccountButtons() {
    return GridView.count(
        childAspectRatio: 3,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: Provider.of<AccountsData>(context)
            .accounts
            .map((e) => buildButton(e))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.grey,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: HomepageCard(
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('List of accounts'),
                  makeAccountButtons(),
                  FlatButton(
                    color: Colors.blueGrey,
                    child: Text('Add account'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: HomepageCard(
              cardChild: Text(
                currentSelection?.toString() ?? 'Select an account.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
