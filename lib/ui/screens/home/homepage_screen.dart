import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/dashboard_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/screens/screens.dart';

class HomepageScreen extends StatefulWidget {
  static final String id = 'homepage_screen';

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  String title = 'DASHBOARD';

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    return Consumer<ExpenseViewModel>(builder: (context, model, child) {
      model.userData = userData;
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(title),
        ),
        drawer: SidebarMenu(),
        body: PageView(
          onPageChanged: (index) {
            setState(() {
              if (index == 0) {
                title = 'DASHBOARD';
              } else if (index == 1) {
                title = 'RECORDS';
              } else {
                title = '';
              }
            });
          },
          children: <Widget>[
            AccountsTab(),
            HistoryTab(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(),
        floatingActionButton: Consumer<DashboardViewModel>(
            builder: (context, dashboardModel, child) {
          return FloatingActionButton(
            backgroundColor: kBlack,
            child: Icon(Icons.add),
            onPressed: () {
              model.newRecord();
              int targetIndex = dashboardModel.getSelectedAccount()?.index ?? 0;
              model.changeAccount(targetIndex == -1 ? 0 : targetIndex);
              Navigator.pushNamed(context, ExpenseScreen.id);
            },
          );
        }),
      );
    });
  }
}
