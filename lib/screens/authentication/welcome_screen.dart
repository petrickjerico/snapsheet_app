import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snapsheetapp/components/button/rounded_button.dart';
import 'package:snapsheetapp/services/auth.dart';
import 'package:snapsheetapp/shared/constants.dart';
import 'package:snapsheetapp/shared/loading.dart';

import 'email.dart';

class WelcomeScreen extends StatefulWidget {
  static final String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/images/snapsheet_logo.png'),
                    height: 150.0,
                  ),
                  Text(
                    'SNAPSHEET',
                    textAlign: TextAlign.center,
                    style: kWelcomeTextStyle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RoundedButton(
                    textColor: Colors.black,
                    color: Colors.white,
                    onPressed: () async {
                      //Go to login screen.
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithGoogle();
                      if (result == null) {
                        setState(() => loading = false);
                      }
                    },
                    title: 'Google',
                    icon: Icon(
                      FontAwesomeIcons.google,
                      color: Colors.black,
                    ),
                  ),
                  RoundedButton(
                    textColor: Colors.white,
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pushNamed(context, Email.id);
                    },
                    title: 'Email',
                    icon: Icon(
                      Icons.mail,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
