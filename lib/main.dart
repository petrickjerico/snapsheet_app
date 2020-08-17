import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/bulk_scan/bulk_scan_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/category/category_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/recurring/recurring_viewmodel.dart';
import 'file:///C:/Users/jtedd/AndroidStudioProjects/snapsheet_app/lib/business_logic/view_models/user_data/user_data_impl.dart';
import 'package:snapsheetapp/services/auth/auth_impl.dart';
import 'file:///C:/Users/jtedd/AndroidStudioProjects/snapsheet_app/lib/ui/views/bulk_scan/receipt_preview.dart';
import 'package:snapsheetapp/ui/screens/accounts/select_account_screen.dart';
import 'package:snapsheetapp/ui/screens/categories/category_popup.dart';
import 'package:snapsheetapp/ui/screens/categories/category_screen.dart';
import 'package:snapsheetapp/ui/screens/categories/select_category_screen.dart';
import 'package:snapsheetapp/ui/screens/recurring/add_recurring_screen.dart';
import 'package:snapsheetapp/ui/screens/recurring/recurring_screen.dart';
import 'package:snapsheetapp/ui/screens/screens.dart';
import 'package:snapsheetapp/ui/screens/splash_screen.dart';

import 'business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'ui/config/theme.dart';

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
        ChangeNotifierProvider<HomepageViewModel>(
            create: (context) => HomepageViewModel()),
        ChangeNotifierProvider<BulkScanViewModel>(
            create: (context) => BulkScanViewModel()),
        ChangeNotifierProvider<RecurringViewModel>(
            create: (context) => RecurringViewModel()),
        ChangeNotifierProvider<CategoryViewModel>(
            create: (context) => CategoryViewModel()),
        ChangeNotifierProvider<UserData>(create: (context) => UserData())
      ],
      child: MaterialApp(
        theme: ThemeData(
            colorScheme: kFirstColorScheme,
            canvasColor: kFirstColorScheme.background),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          Wrapper.id: (context) => Wrapper(),
          LoginScreen.id: (context) => LoginScreen(),
          HomepageScreen.id: (context) => HomepageScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          ExpenseScreen.id: (context) => ExpenseScreen(),
          EditExpenseInfoScreen.id: (context) => EditExpenseInfoScreen(),
          ExportScreen.id: (context) => ExportScreen(),
          CategoryScreen.id: (context) => CategoryScreen(),
          SelectCategoryScreen.id: (context) => SelectCategoryScreen(),
          SelectAccountScreen.id: (context) => SelectAccountScreen(),
          EditProfileScreen.id: (context) => EditProfileScreen(),
          SettingsScreen.id: (context) => SettingsScreen(),
          BulkScanScreen.id: (context) => BulkScanScreen(),
          RecurringScreen.id: (context) => RecurringScreen(),
          AddRecurringScreen.id: (context) => AddRecurringScreen(),
          ReceiptPreviewScreen.id: (context) => ReceiptPreviewScreen(),
          EditAccountsOrder.id: (context) => EditAccountsOrder(),
        },
      ),
    );
  }
}
