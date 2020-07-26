import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'package:snapsheetapp/ui/components/account/accounts_carousel.dart';
import 'package:snapsheetapp/ui/components/dialog/delete_dialog.dart';
import 'package:snapsheetapp/ui/components/empty_state.dart';
import 'package:snapsheetapp/ui/components/stats/statistics.dart';
import 'package:snapsheetapp/ui/config/colors.dart';
import 'package:snapsheetapp/ui/config/decoration.dart';
import 'package:snapsheetapp/ui/screens/screens.dart';
import 'package:snapsheetapp/ui/screens/sidebar/sidebar_menu.dart';

import 'add_account_popup.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomepageViewModel>(context);
    int accountsCount = model.accounts.length;
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: kScaffoldBackgroundColour,
      drawer: SidebarMenu(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kHomepageBackgroundTransparency,
        title: Text(
          "DASHBOARD",
        ),
        textTheme: Theme.of(context).textTheme,
        iconTheme: Theme.of(context).iconTheme,
        actions: <Widget>[
          model.userData.credentials['isDemo']
              ? FlatButton(
                  textColor: Colors.black,
                  child: Text('Exit Demo'),
                  onPressed: () {
                    showDialog(
                        context: context,
                        child: DeleteDialog(
                          title: "Exit Demo",
                          message: "Are you sure you want to exit demo?",
                          onDelete: () {
                            model.userData.demoDone();
                            setState(() {});
                          },
                        ));
                  },
                )
              : SizedBox.shrink()
        ],
      ),
      body: accountsCount < 1
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
              messageColor: Colors.grey,
              message: 'There is no account yet.\n'
                  'Tap to create one.',
              icon: Icon(
                Icons.add_circle,
                color: Colors.grey,
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
                    child: Statistics(),
                  ),
                ),
              ],
            ),
    );
  }
}
