import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/archive/temp_data.dart';
import 'package:snapsheetapp/models/user.dart';
import 'package:snapsheetapp/screens/authentication/profile_setup.dart';
import 'package:snapsheetapp/screens/authentication/wrapper.dart';
import 'package:snapsheetapp/screens/calculator/addexpenses_screen.dart';
import 'package:snapsheetapp/screens/calculator/editinfo_screen.dart';
import 'package:snapsheetapp/screens/home/edit_order_accounts.dart';
import 'package:snapsheetapp/screens/sidebar/addcategory_screen.dart';
import 'package:snapsheetapp/screens/authentication/email.dart';
import 'package:snapsheetapp/screens/authentication/welcome_screen.dart';
import 'package:snapsheetapp/screens/sidebar/editprofile_screen.dart';
import 'package:snapsheetapp/screens/sidebar/exportselect_screen.dart';
import 'package:snapsheetapp/screens/home/homepage_screen.dart';
import 'package:snapsheetapp/screens/sidebar/bulk_scan_screen.dart';
import 'package:snapsheetapp/screens/sidebar/receipt_preview.dart';
import 'package:snapsheetapp/screens/sidebar/settings_screen.dart';
import 'package:snapsheetapp/screens/splash.dart';
import 'package:snapsheetapp/services/auth.dart';
import 'models/user_data.dart';

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
        StreamProvider<User>.value(value: AuthService().user),
        ChangeNotifierProvider<UserData>(create: (context) => UserData()),
      ],
      child: MaterialApp(
        initialRoute: Wrapper.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          Wrapper.id: (context) => Wrapper(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          HomepageScreen.id: (context) => HomepageScreen(),
          EmailScreen.id: (context) => EmailScreen(),
          ProfileSetupScreen.id: (context) => ProfileSetupScreen(),
          AddExpensesScreen.id: (context) => AddExpensesScreen(),
          ExportSelectScreen.id: (context) => ExportSelectScreen(),
          AddCategoryScreen.id: (context) => AddCategoryScreen(),
          EditProfileScreen.id: (context) => EditProfileScreen(),
          SettingsScreen.id: (context) => SettingsScreen(),
          EditInfoScreen.id: (context) => EditInfoScreen(),
          BulkScanScreen.id: (context) => BulkScanScreen(),
          EditAccountsOrder.id: (context) => EditAccountsOrder(),
        },
        theme: ThemeData.light().copyWith(primaryColor: Colors.black),
      ),
    );
  }
}
