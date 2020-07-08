import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/bulk_scan/bulk_scan_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/dashboard_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/export/export_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/services/auth/auth_impl.dart';
import 'package:snapsheetapp/ui/components/scanner/receipt_preview.dart';
import 'package:snapsheetapp/ui/screens/screens.dart';
import 'package:snapsheetapp/ui/screens/splash_screen.dart';
import 'package:snapsheetapp/ui/shared/splash.dart';

void main() {
  //To lock orientation of the app.
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(Snapsheet());
  });
}

class Snapsheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: AuthServiceImpl().user),
        ChangeNotifierProvider<ExpenseViewModel>(
            create: (context) => ExpenseViewModel()),
        ChangeNotifierProvider<DashboardViewModel>(
            create: (context) => DashboardViewModel()),
        ChangeNotifierProvider<BulkScanViewModel>(
            create: (context) => BulkScanViewModel()),
        ChangeNotifierProvider<UserData>(
          create: (context) => UserData(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          Wrapper.id: (context) => Wrapper(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          HomepageScreen.id: (context) => HomepageScreen(),
          EmailScreen.id: (context) => EmailScreen(),
          ExpenseScreen.id: (context) => ExpenseScreen(),
          EditExpenseInfoScreen.id: (context) => EditExpenseInfoScreen(),
          ExportScreen.id: (context) => ExportScreen(),
//          AddCategoryScreen.id: (context) => AddCategoryScreen(),
          EditProfileScreen.id: (context) => EditProfileScreen(),
          SettingsScreen.id: (context) => SettingsScreen(),
          BulkScanScreen.id: (context) => BulkScanScreen(),
          ReceiptPreviewScreen.id: (context) => ReceiptPreviewScreen(),
          EditAccountsOrder.id: (context) => EditAccountsOrder(),
        },
        theme: ThemeData.light().copyWith(primaryColor: Colors.black),
      ),
    );
  }
}
