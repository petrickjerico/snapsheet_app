import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/services/auth/auth_impl.dart';
import 'package:snapsheetapp/ui/views/screens.dart';
import 'business_logic/view_models/view_models.dart';
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
