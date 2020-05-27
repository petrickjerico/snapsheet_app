import 'package:flutter/material.dart';
import 'package:snapsheetapp/screens/addcategory_screen.dart';
import 'package:snapsheetapp/screens/calculator_screen.dart';
import 'package:snapsheetapp/screens/editprofile_screen.dart';
import 'package:snapsheetapp/screens/exportdone_screen.dart';
import 'package:snapsheetapp/screens/exportselect_screen.dart';
import 'package:snapsheetapp/screens/homepage_screen.dart';
import 'package:snapsheetapp/screens/login_screen.dart';
import 'package:snapsheetapp/screens/registration_screen.dart';
import 'package:snapsheetapp/screens/settings_screen.dart';
import 'package:snapsheetapp/screens/welcome_screen.dart';

void main() {
  runApp(Snapsheet());
}

class Snapsheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: WelcomeScreen.id, routes: {
      WelcomeScreen.id: (context) => WelcomeScreen(),
      HomepageScreen.id: (context) => HomepageScreen(),
      LoginScreen.id: (context) => LoginScreen(),
      RegistrationScreen.id: (context) => RegistrationScreen(),
      CalculatorScreen.id: (context) => CalculatorScreen(),
      ExportSelectScreen.id: (context) => ExportSelectScreen(),
      ExportDoneScreen.id: (context) => ExportDoneScreen(),
      AddCategoryScreen.id: (context) => AddCategoryScreen(),
      EditProfileScreen.id: (context) => EditProfileScreen(),
      SettingsScreen.id: (context) => SettingsScreen(),
    });
  }
}
