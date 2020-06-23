import 'package:flutter/material.dart';
import 'package:snapsheetapp/services/auth/auth_impl.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/shared/shared.dart';

class RegisterScreen extends StatefulWidget {
  static final String id = 'register_screen';

  final Function updateCredential;
  final Function toggleView;
  final String email;
  final String pwd;

  RegisterScreen(
      {this.updateCredential, this.toggleView, this.email, this.pwd});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthServiceImpl _auth = AuthServiceImpl();
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
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.black,
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
                        style: kWhiteTextStyle,
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
                        style: kWhiteTextStyle,
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
                          'Sign up',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic user = await _auth
                                .registerWithEmailAndPassword(email, pwd);
                            if (user != null) {
                              Navigator.pop(context);
                            }
                            if (user == null) {
                              setState(() {
                                error = 'please supply a valid email';
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
                            'Already have an account?',
                            style: kWhiteTextStyle,
                          ),
                          FlatButton(
                            onPressed: () {
                              widget.updateCredential(email, pwd);
                              widget.toggleView();
                            },
                            child: Text(
                              'Sign in',
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
