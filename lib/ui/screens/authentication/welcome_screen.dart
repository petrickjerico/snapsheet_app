import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snapsheetapp/services/auth/auth_impl.dart';
import 'package:snapsheetapp/ui/components/button/rounded_button.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/screens/authentication/email_screen.dart';
import 'package:snapsheetapp/ui/screens/home/homepage_screen.dart';
import 'package:snapsheetapp/ui/shared/loading.dart';

class WelcomeScreen extends StatefulWidget {
  static final String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final AuthServiceImpl _auth = AuthServiceImpl();
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
                  Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset('assets/images/snapsheet_logo.png'),
                        height: 60.0,
                      ),
                      Text(
                        'SNAPSHEET',
                        textAlign: TextAlign.center,
                        style: kWelcomeTextStyle,
                      ),
                    ],
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
                      setState(() => loading = false);
                      if (result != null) {
                        Navigator.pushReplacementNamed(
                            context, HomepageScreen.id);
                      }
                    },
                    title: 'Login with Google',
                    icon: Icon(
                      FontAwesomeIcons.google,
                      color: Colors.black,
                    ),
                  ),
                  RoundedButton(
                    textColor: Colors.white,
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pushNamed(context, EmailScreen.id);
                    },
                    title: 'Login with Email',
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
