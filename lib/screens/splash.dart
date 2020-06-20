import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/models/models.dart';
import 'package:snapsheetapp/screens/authentication/wrapper.dart';
import 'package:snapsheetapp/screens/home/homepage_screen.dart';
import 'package:snapsheetapp/services/auth.dart';
import 'package:snapsheetapp/shared/snapsheet/snapsheet_logo.dart';

import 'authentication/welcome_screen.dart';

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
    AuthService _auth = AuthService();
    var user = await _auth.currentUser();
    print("CHECKIFUSERLOGGEDIN ${user.toString()}");

    try {
      if (user != null) {
        Navigator.pushReplacementNamed(context, HomepageScreen.id);
      } else {
        Navigator.pushReplacementNamed(context, Wrapper.id);
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
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: Colors.white,
        child: Center(
          child: Hero(
            tag: 'logo',
            child: SnapSheetLogo(
              size: 200,
            ),
          ),
        ),
      ),
    );
  }
}
