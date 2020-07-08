import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snapsheetapp/services/auth/auth_impl.dart';
import 'package:snapsheetapp/ui/components/button/rounded_button.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/screens/home/homepage_screen.dart';
import 'package:snapsheetapp/ui/shared/shared.dart';

class SignupScreen extends StatefulWidget {
  static final String id = 'signup_screen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthServiceImpl _auth = AuthServiceImpl();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String pwd = '';
  String error = '';

  FocusNode pwdFocus = FocusNode();

  void signUp() async {
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      dynamic result = await _auth.registerWithEmailAndPassword(email, pwd);

      if (result == null) {
        setState(() {
          error = 'Invalid email and password';
          loading = false;
        });
      } else {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SnapSheetBanner(),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: email,
                      decoration: kTextFieldDecorationLogin,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.left,
                      validator: (val) =>
                          val.isEmpty ? "Enter a valid email" : null,
                      onChanged: (val) => setState(() => email = val),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (val) {
                        FocusScope.of(context).requestFocus(pwdFocus);
                      },
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      initialValue: pwd,
                      decoration: kTextFieldDecorationLogin.copyWith(
                          hintText: 'Password'),
                      cursorColor: Colors.black,
                      textAlign: TextAlign.left,
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) => setState(() => pwd = val),
                      textInputAction: TextInputAction.done,
                      focusNode: pwdFocus,
                      onFieldSubmitted: (val) => signUp(),
                    ),
                    SizedBox(height: 12),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                    RoundedButton(
                      textColor: Colors.white,
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pushNamed(context, SignupScreen.id);
                      },
                      title: 'Login',
                      icon: Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                    ),
                    Divider(),
                    RoundedButton(
                      textColor: Colors.black,
                      color: Colors.white,
                      onPressed: () async {
                        //Go to login screen.
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithGoogle();
                        setState(() => loading = false);
                      },
                      title: 'Login with Google',
                      icon: Icon(
                        FontAwesomeIcons.google,
                        color: Colors.black,
                      ),
                    ),
                    Login()
                  ],
                ),
              ),
            ),
          );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Already have an account? ",
          style: TextStyle(fontSize: 12),
        ),
        FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "login",
              style: kLoginSignupTextStyle,
            ))
      ],
    );
  }
}
