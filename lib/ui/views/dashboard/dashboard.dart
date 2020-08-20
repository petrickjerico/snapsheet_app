import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/shared/shared.dart';
import 'accounts_carousel.dart';
import 'package:snapsheetapp/ui/views/dashboard/statistics.dart';
import 'package:snapsheetapp/ui/views/screens.dart';

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
      backgroundColor: kLightBlueBackground,
      drawer: SidebarMenu(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        textTheme: Theme.of(context).textTheme,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          "DASHBOARD",
        ),
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
                            Navigator.of(this.context).pop();
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
