import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapsheetapp/services/auth/auth_impl.dart';
import 'package:snapsheetapp/ui/components/button/rounded_button.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/shared/loading.dart';

class EmailScreen extends StatefulWidget {
  static final String id = 'email_screen';

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final AuthServiceImpl _auth = AuthServiceImpl();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String pwd = '';
  String error = '';

  FocusNode pwdFocus = FocusNode();

  void proceed({bool isSignIn}) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      dynamic result = await (isSignIn
          ? _auth.signInWithEmailAndPassword(email, pwd)
          : _auth.registerWithEmailAndPassword(email, pwd));

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
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Welcome!",
                      style: kWelcomeTextStyle,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      initialValue: email,
                      decoration: kTextFieldDecorationLogin,
                      cursorColor: Colors.black,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.left,
                      validator: (val) =>
                          val.isEmpty ? "Enter a valid email" : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
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
                      onChanged: (val) {
                        setState(() => pwd = val);
                      },
                      textInputAction: TextInputAction.done,
                      focusNode: pwdFocus,
                      onFieldSubmitted: (val) => proceed(isSignIn: true),
                    ),
                    SizedBox(height: 12),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                    RoundedButton(
                      textColor: Colors.black,
                      color: Colors.white,
                      onPressed: () => proceed(isSignIn: true),
                      title: 'Sign in',
                    ),
                    RoundedButton(
                      textColor: Colors.white,
                      color: Colors.black,
                      onPressed: () => proceed(isSignIn: false),
                      title: 'Sign Up',
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
