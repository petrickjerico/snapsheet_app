import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/homepage_card.dart';
import '../constants.dart';
import 'file:///C:/Users/jtedd/AndroidStudioProjects/snapsheet_app/lib/archive/account.dart';
import 'package:snapsheetapp/models/user_data.dart';

class AccountsTab extends StatelessWidget {
  Widget buildButton(String accTitle, UserData userData) {
    int accountId = userData.accounts.indexOf(accTitle);
    return OutlineButton(
      child: Text(accTitle),
      onPressed: () {
        userData.selectAccount(accountId);
      },
    );
  }

  Widget makeAccountButtons(UserData userData) {
    return GridView.count(
        childAspectRatio: 3,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children:
            userData.accounts.map((e) => buildButton(e, userData)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) {
        return Container(
          padding: EdgeInsets.all(20.0),
          color: Colors.grey,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: HomepageCard(
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('List of accounts'),
                      makeAccountButtons(userData),
                      FlatButton(
                        color: Colors.blueGrey,
                        child: Text('Add account'),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SingleChildScrollView(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: AddAccountPopup(),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: HomepageCard(
                  cardChild: Text(
                    userData.selectedAccount?.toString() ??
                        'Select an account.',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AddAccountPopup extends StatelessWidget {
  String accountTitle;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
      return Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 10.0),
                TextField(
                  autofocus: true,
                  onChanged: (value) {
                    accountTitle = value;
                  },
                  decoration: kTextFieldDecorationLogin.copyWith(
                      hintText: 'Name your new account'),
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
                  userData.addAccount(accountTitle);
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      );
    });
  }
}
