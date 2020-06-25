import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/user.dart';
import 'package:snapsheetapp/business_logic/view_models/bulk_scan/bulk_scan_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/dashboard_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/export/export_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/ui/screens/screens.dart';
import 'package:snapsheetapp/ui/shared/loading.dart';

class Wrapper extends StatefulWidget {
  static final String id = 'wrapper';

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool loadDone = false;
  bool initialized = false;

  void loadCallback() {
    setState(() {
      loadDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    UserData userData = Provider.of<UserData>(context, listen: false);
    // either home or authenticate
    if (user == null) {
      return WelcomeScreen();
    } else {
      if (!initialized) {
        userData.init(user, loadCallback);
        setState(() {
          initialized = true;
        });
        return Loading();
      } else {
        if (!loadDone) {
          return Loading();
        } else {
          ExpenseViewModel expenseViewModel =
              Provider.of<ExpenseViewModel>(context, listen: false);
          DashboardViewModel dashboardViewModel =
              Provider.of<DashboardViewModel>(context, listen: false);
          ExportViewModel exportViewModel =
              Provider.of<ExportViewModel>(context, listen: false);
          BulkScanViewModel bulkScanViewModel =
              Provider.of<BulkScanViewModel>(context, listen: false);
          expenseViewModel.init(userData);
          dashboardViewModel.init(userData);
          exportViewModel.init(userData);
          bulkScanViewModel.init(userData);
          return HomepageScreen();
        }
      }
    }
  }
}
