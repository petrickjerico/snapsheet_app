import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/archive/temp_data.dart';
import 'package:snapsheetapp/models/user.dart';
import 'package:snapsheetapp/screens/addcategory_screen.dart';
import 'package:snapsheetapp/screens/addexpenses_screen.dart';
import 'package:snapsheetapp/screens/authentication/email.dart';
import 'package:snapsheetapp/screens/authentication/welcome_screen.dart';
import 'package:snapsheetapp/screens/editinfo_screen.dart';
import 'package:snapsheetapp/screens/editprofile_screen.dart';
import 'package:snapsheetapp/screens/exportselect_screen.dart';
import 'package:snapsheetapp/screens/homepage_screen.dart';
import 'package:snapsheetapp/screens/login_screen.dart';
import 'package:snapsheetapp/screens/registration_screen.dart';
import 'package:snapsheetapp/screens/bulk_scan_screen.dart';
import 'package:snapsheetapp/screens/settings_screen.dart';
import 'package:snapsheetapp/screens/wrapper.dart';
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
          Wrapper.id: (context) => Wrapper(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          HomepageScreen.id: (context) => HomepageScreen(),
          Email.id: (context) => Email(),
          AddExpensesScreen.id: (context) => AddExpensesScreen(),
          ExportSelectScreen.id: (context) => ExportSelectScreen(),
          AddCategoryScreen.id: (context) => AddCategoryScreen(),
          EditProfileScreen.id: (context) => EditProfileScreen(),
          SettingsScreen.id: (context) => SettingsScreen(),
          EditInfoScreen.id: (context) => EditInfoScreen(),
          BulkScanScreen.id: (context) => BulkScanScreen(),
        },
        theme: ThemeData.light().copyWith(primaryColor: Colors.black),
      ),
    );
  }
}
