import 'package:flutter/material.dart';
import 'file:///C:/Users/jtedd/AndroidStudioProjects/snapsheet_app/lib/archive/register.dart';
import 'file:///C:/Users/jtedd/AndroidStudioProjects/snapsheet_app/lib/archive/sign_in.dart';

class SignInRegisterController extends StatefulWidget {
  static final String id = 'sign_in_register_controller';

  @override
  _SignInRegisterControllerState createState() =>
      _SignInRegisterControllerState();
}

class _SignInRegisterControllerState extends State<SignInRegisterController> {
  bool showSignIn = true;
  String email = '';
  String pwd = '';

  void toggleView() => setState(() => showSignIn = !showSignIn);

  void updateCredential(String newEmail, String newPwd) {
    setState(() {
      email = newEmail;
      pwd = newPwd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? SignInScreen(
            updateCredential: updateCredential,
            toggleView: toggleView,
            email: email,
            pwd: pwd,
          )
        : RegisterScreen(
            updateCredential: updateCredential,
            toggleView: toggleView,
            email: email,
            pwd: pwd,
          );
  }
}
