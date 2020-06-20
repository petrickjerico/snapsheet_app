import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/models/user.dart';
import 'package:snapsheetapp/screens/authentication/welcome_screen.dart';
import 'package:snapsheetapp/screens/home/homepage_screen.dart';

class Wrapper extends StatelessWidget {
  static final String id = 'wrapper';

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    print(user);
    print("WRAPPER");
    // either home or authenticate
    if (user == null) {
      return WelcomeScreen();
    } else {
      print('RETURN HOMEPAGE');
      return HomepageScreen();
    }
  }
}
