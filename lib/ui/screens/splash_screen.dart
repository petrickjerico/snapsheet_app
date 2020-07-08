import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/bulk_scan/bulk_scan_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/dashboard_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/services/auth/auth_impl.dart';
import 'package:snapsheetapp/ui/screens/screens.dart';
import 'package:snapsheetapp/ui/shared/splash.dart';

class SplashScreen extends StatefulWidget {
  static final String id = 'splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void afterFirstLayout(BuildContext context) async {
    Future.delayed(Duration(seconds: 1), _checkIfUserIsLoggedIn);
  }

  _checkIfUserIsLoggedIn() async {
    AuthService _auth = AuthServiceImpl();
    var user = await _auth.currentUser();
    print("CHECKIFUSERLOGGEDIN ${user.toString()}");

    try {
      if (user != null) {
        UserData userData = Provider.of<UserData>(context, listen: false);

        await userData.init(user);
        ExpenseViewModel expenseViewModel =
            Provider.of<ExpenseViewModel>(context, listen: false);
        DashboardViewModel dashboardViewModel =
            Provider.of<DashboardViewModel>(context, listen: false);
        BulkScanViewModel bulkScanViewModel =
            Provider.of<BulkScanViewModel>(context, listen: false);
        expenseViewModel.init(userData);
        dashboardViewModel.init(userData);
        bulkScanViewModel.init(userData);
        Navigator.pushReplacementNamed(context, HomepageScreen.id);
      } else {
        Navigator.pushReplacementNamed(context, WelcomeScreen.id);
      }
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                padding: EdgeInsets.all(40),
                child: Text(e.message),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Splash();
  }
}
