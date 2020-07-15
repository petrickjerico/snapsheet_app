import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/homepage_viewmodel.dart';
import 'package:snapsheetapp/ui/components/account/accounts_carousel.dart';
import 'package:snapsheetapp/ui/components/empty_state.dart';
import 'package:snapsheetapp/ui/components/stats/statistics.dart';
import 'package:snapsheetapp/ui/config/colors.dart';
import 'package:snapsheetapp/ui/config/decoration.dart';

import 'add_account_popup.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    int accountsCount = Provider.of<HomepageViewModel>(context).accounts.length;
    return accountsCount < 1
        ? EmptyState(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddAccountPopup(),
                ),
                shape: kBottomSheetShape,
              );
            },
            messageColor: Colors.white30,
            message: 'There is no account yet.\n'
                'Tap to create one.',
            icon: Icon(
              Icons.add_circle,
              color: Colors.white30,
              size: 120.0,
            ),
          )
        : Column(
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
