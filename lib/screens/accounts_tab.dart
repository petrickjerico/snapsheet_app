import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/add_account_popup.dart';
import 'package:snapsheetapp/components/homepage_card.dart';
import 'package:snapsheetapp/components/rename_account_popup.dart';
import 'package:snapsheetapp/components/statistics.dart';
import 'package:snapsheetapp/models/account.dart';
import '../shared/constants.dart';
import 'package:snapsheetapp/models/user_data.dart';

class AccountsTab extends StatelessWidget {
  Future<void> showChoiceDialog(BuildContext context) {
    UserData userData = Provider.of<UserData>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Edit"),
                  onTap: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SingleChildScrollView(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: RenameAccountPopup(userData.selectedAccount),
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
                SizedBox(height: 20),
                GestureDetector(
                  child: Text("Delete"),
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        titlePadding:
                            EdgeInsets.only(left: 20, right: 20, top: 20),
                        contentPadding: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 10),
                        title: Text("Delete account?"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Are you sure you want to delete ${userData.accounts[userData.selectedAccount].title}?',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                FlatButton(
                                  child: Text(
                                    'DELETE',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  onPressed: () {
                                    userData.deleteAccount(
                                        userData.selectedAccount);
                                    Navigator.pop(context);
                                  },
                                ),
                                OutlineButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Text('NO'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget makeAccountButtons(UserData userData, BuildContext context) {
    List<Widget> children = userData.accounts.map((e) {
      int accId = userData.accounts.indexOf(e);
      return MaterialButton(
        color: e.isSelected ? e.color : Colors.grey,
        elevation: 0,
        child: Text(
          e.title,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          userData.selectAccount(accId);
          for (Account acc in userData.accounts) {
            if (userData.accounts.indexOf(acc) != accId) {
              acc.isSelected = false;
            } else {
              acc.isSelected = true;
            }
          }
        },
        onLongPress: () {
          userData.selectAccount(accId);
          showChoiceDialog(context);
        },
      );
    }).toList();

    children.add(
      OutlineButton(
        padding: EdgeInsets.all(0),
        borderSide: BorderSide(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.add,
              size: 15.0,
              color: Colors.white,
            ),
            SizedBox(
              width: 2.0,
            ),
            Text(
              'ADD ACCOUNT',
              style: TextStyle(fontSize: 13.0, color: Colors.white),
            ),
            SizedBox(
              width: 2.0,
            ),
          ],
        ),
        textColor: Colors.black,
        onPressed: () {
          userData.selectAccount(userData.records.length);
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
        },
      ),
    );

    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: GridView.count(
        childAspectRatio: 3,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: children,
      ),
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
              Container(
                color: Colors.black87,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        top: 15.0,
                      ),
                      child: Text(
                        'List of accounts',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    makeAccountButtons(userData, context),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Visibility(
                          visible: userData.selectedAccount != -1,
                          child: FlatButton(
                              child: Text(
                                'SELECT ALL',
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline),
                              ),
                              onPressed: () {
                                userData.selectAccount(-1);
                                for (Account acc in userData.accounts) {
                                  acc.isSelected = true;
                                }
                              }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Statistics(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
