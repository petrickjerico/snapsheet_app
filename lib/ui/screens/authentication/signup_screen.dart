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
  String confirmPwd = '';
  String error = '';
  bool obscurePwd = true;

  FocusNode pwdFocus = FocusNode();
  FocusNode confirmPwdFocus = FocusNode();

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
        : GestureDetector(
            onTap: () => unfocus(context),
            child: Scaffold(
              backgroundColor: Colors.white,
              resizeToAvoidBottomPadding: false,
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
                      Theme(
                        data: Theme.of(context)
                            .copyWith(primaryColor: Colors.black),
                        child: TextFormField(
                          initialValue: email,
                          decoration: kEmailTextFieldDecoration,
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
                      ),
                      SizedBox(height: 12),
                      Theme(
                        data: Theme.of(context)
                            .copyWith(primaryColor: Colors.black),
                        child: TextFormField(
                          initialValue: pwd,
                          decoration: kPasswordTextFieldDecoration.copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                obscurePwd
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  obscurePwd = !obscurePwd;
                                });
                              },
                            ),
                          ),
                          cursorColor: Colors.black,
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical(y: 0),
                          obscureText: obscurePwd,
                          validator: (val) => val.length < 6
                              ? 'Enter a password 6+ chars long'
                              : null,
                          onChanged: (val) => setState(() => pwd = val),
                          textInputAction: TextInputAction.next,
                          focusNode: pwdFocus,
                          onFieldSubmitted: (val) {
                            FocusScope.of(context)
                                .requestFocus(confirmPwdFocus);
                          },
                        ),
                      ),
                      SizedBox(height: 12),
                      Theme(
                        data: Theme.of(context)
                            .copyWith(primaryColor: Colors.black),
                        child: TextFormField(
                          initialValue: confirmPwd,
                          decoration: kConfirmPasswordTextFieldDecoration,
                          cursorColor: Colors.black,
                          textAlign: TextAlign.left,
                          obscureText: true,
                          validator: (val) =>
                              val != pwd ? 'Password does not match' : null,
                          onChanged: (val) => setState(() => confirmPwd = val),
                          textInputAction: TextInputAction.done,
                          focusNode: confirmPwdFocus,
                          onFieldSubmitted: (val) => signUp(),
                        ),
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
                          signUp();
                        },
                        title: 'Sign up',
                        icon: Icon(
                          FontAwesomeIcons.solidEnvelope,
                          color: Colors.white,
                          size: 20,
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
                          if (result != null) {
                            await Future.delayed(Duration(seconds: 1),
                                () => Navigator.pop(context));
                          }
                          setState(() => loading = false);
                        },
                        title: 'Sign up with Google',
                        icon: Icon(
                          FontAwesomeIcons.google,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                      Login()
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Already have an account? ",
            style: TextStyle(fontSize: 12),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              "Login",
              style: kLoginSignupTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
