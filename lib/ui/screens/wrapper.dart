import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/user.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/ui/screens/screens.dart';

class Wrapper extends StatelessWidget {
  static final String id = 'wrapper';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // either home or authenticate
    if (user == null) {
      return WelcomeScreen();
    } else {
      return ChangeNotifierProvider<UserData>(
        create: (context) => UserData(user),
        child: HomepageScreen(),
      );
    }
  }
}
