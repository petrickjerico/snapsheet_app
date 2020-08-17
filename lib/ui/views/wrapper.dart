import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/user.dart';
import 'package:snapsheetapp/business_logic/view_models/view_models.dart';
import 'package:snapsheetapp/ui/shared/loading.dart';
import 'package:snapsheetapp/ui/views/screens.dart';

class Wrapper extends StatefulWidget {
  static final String id = 'wrapper';

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool loadDone = false;
  loadCallback() => setState(() => loadDone = true);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    UserData userData = Provider.of<UserData>(context, listen: false);
    // either home or authenticate
    if (user == null) {
      return LoginScreen();
    } else {
      if (!loadDone) {
        userData.init(user, loadCallback);
        return Loading();
      } else {
        ExpenseViewModel expenseViewModel =
            Provider.of<ExpenseViewModel>(context, listen: false);
        HomepageViewModel dashboardViewModel =
            Provider.of<HomepageViewModel>(context, listen: false);
        BulkScanViewModel bulkScanViewModel =
            Provider.of<BulkScanViewModel>(context, listen: false);
        RecurringViewModel recurringViewModel =
            Provider.of<RecurringViewModel>(context, listen: false);
        CategoryViewModel categoryViewModel =
            Provider.of<CategoryViewModel>(context, listen: false);
        expenseViewModel.init(userData);
        dashboardViewModel.init(userData);
        bulkScanViewModel.init(userData);
        recurringViewModel.init(userData);
        categoryViewModel.init(userData);
        return HomepageScreen();
      }
    }
  }
}
