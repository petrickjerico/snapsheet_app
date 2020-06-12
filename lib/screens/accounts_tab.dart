import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/add_account_popup.dart';
import 'package:snapsheetapp/components/homepage_card.dart';
import 'package:snapsheetapp/components/statistics.dart';
import '../constants.dart';
import 'package:snapsheetapp/models/user_data.dart';

class AccountsTab extends StatelessWidget {
  Widget makeAccountButtons(UserData userData, BuildContext context) {
    List<Widget> children = userData.accounts.map((e) {
      int accId = userData.accounts.indexOf(e);
      return MaterialButton(
        color: e.color,
        elevation: 0,
        child: Text(
          e.title,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          userData.selectAccount(accId);
        },
      );
    }).toList();

    children.add(OutlineButton(
        padding: EdgeInsets.all(0),
        borderSide: BorderSide(color: Colors.black),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.add, size: 15.0),
            SizedBox(
              width: 2.0,
            ),
            Text(
              'ADD ACCOUNT',
              style: TextStyle(fontSize: 13.0),
            ),
            SizedBox(
              width: 2.0,
            ),
          ],
        ),
        textColor: Colors.black,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddAccountPopup(),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
          );
        }));

    return GridView.count(
      childAspectRatio: 3,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) {
        return Container(
          color: Colors.grey,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('List of accounts'),
                      makeAccountButtons(userData, context),
                      Visibility(
                        visible: userData.selectedAccount != -1,
                        child: MaterialButton(
                          color: Colors.black,
                          elevation: 0,
                          child: Text(
                            'Select All',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            userData.selectAccount(-1);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: HomepageCard(
                      cardChild: Statistics(),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}

class RenameAccountPopup extends StatelessWidget {
  RenameAccountPopup(this.id);

  int id;
  String accountTitle;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
                    initialValue: accountTitle,
                    autofocus: true,
                    onChanged: (value) {
                      accountTitle = value;
                    },
                    decoration: kTextFieldDecorationLogin.copyWith(
                      hintText: 'Rename your account',
                    ),
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
                    'RENAME',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      userData.renameAccount(id, accountTitle);
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
