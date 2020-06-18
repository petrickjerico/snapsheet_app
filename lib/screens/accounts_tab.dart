import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/add_account_popup.dart';
import 'package:snapsheetapp/components/homepage_card.dart';
import 'package:snapsheetapp/components/list_of_accounts.dart';
import 'package:snapsheetapp/components/rename_account_popup.dart';
import 'package:snapsheetapp/components/statistics.dart';
import 'package:snapsheetapp/models/account.dart';
import '../shared/constants.dart';
import 'package:snapsheetapp/models/user_data.dart';

class AccountsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) {
        return Container(
          color: Colors.grey,
          child: Column(
            children: <Widget>[
              ListOfAccounts(),
              Flexible(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Statistics(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
