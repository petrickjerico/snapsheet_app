import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/account/list_of_accounts.dart';
import 'package:snapsheetapp/components/stats/statistics.dart';
import 'package:snapsheetapp/models/user_data.dart';

class AccountsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) {
        return Container(
          color: Colors.black.withOpacity(0.8),
          child: Column(
            children: <Widget>[
              ListOfAccounts(),
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView(
                    children: <Widget>[
                      Statistics(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
