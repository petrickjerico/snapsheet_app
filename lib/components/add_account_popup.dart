import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/constants.dart';
import 'package:snapsheetapp/models/user_data.dart';

class AddAccountPopup extends StatelessWidget {
  static final _formKey = GlobalKey<FormState>();
  String accountTitle;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
      return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  TextFormField(
                    autofocus: true,
                    onChanged: (value) {
                      accountTitle = value;
                    },
                    decoration: kTextFieldDecorationLogin.copyWith(
                        hintText: 'Name your new account'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
              Container(
                height: 50.0,
                width: 150.0,
                child: FlatButton(
                  color: Colors.black,
                  child: Text(
                    'CREATE',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      userData.addAccount(accountTitle, Colors.black);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
              SizedBox(
                height: 15.0,
              )
            ],
          ),
        ),
      );
    });
  }
}
