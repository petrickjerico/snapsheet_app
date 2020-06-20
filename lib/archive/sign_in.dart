import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/config/config.dart';
import 'package:snapsheetapp/models/user.dart';
import 'package:snapsheetapp/services/auth.dart';
import 'package:snapsheetapp/shared/loading.dart';

class SignInScreen extends StatefulWidget {
  static final String id = 'signin_screen';

  final Function updateCredential;
  final Function toggleView;
  final String email;
  final String pwd;

  SignInScreen({this.updateCredential, this.toggleView, this.email, this.pwd});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email;
  String pwd;
  String error = '';

  @override
  void initState() {
    super.initState();
    email = widget.email;
    pwd = widget.pwd;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        initialValue: email,
                        validator: (val) =>
                            val.isEmpty ? 'Enter a valid email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        textAlign: TextAlign.center,
                        initialValue: pwd,
                        obscureText: true,
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            pwd = val;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        color: Colors.black,
                        child: Text(
                          'Sign in',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, pwd);

                            if (result != null) {
                              Navigator.pop(context);
                            }
                            if (result == null) {
                              setState(() {
                                error =
                                    'please supply a valid email and password';
                                loading = false;
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don't have an account?",
                            style: kWhiteTextStyle,
                          ),
                          FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              print(email);
                              print(pwd);
                              widget.updateCredential(email, pwd);
                              widget.toggleView();
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(color: kCyan),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )
                    ],
                  ),
                )),
          );
  }
}
