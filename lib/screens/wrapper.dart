import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/models/user.dart';
import 'package:snapsheetapp/screens/homepage_screen.dart';

import 'authentication/welcome_screen.dart';

class Wrapper extends StatelessWidget {
  static final String id = 'wrapper';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // either home or authenticate
    if (user == null) {
      return WelcomeScreen();
    } else {
      return HomepageScreen();
    }
  }
}
