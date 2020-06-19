import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/account/rename_account_popup.dart';
import 'package:snapsheetapp/models/account.dart';
import 'package:snapsheetapp/models/user_data.dart';

import 'account_tile.dart';
import 'add_account_popup.dart';

class ListOfAccounts extends StatelessWidget {
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
      return AccountTile(
        color: e.color,
        title: e.title,
        count: userData.statsCountRecords(accId),
        total: userData.statsGetAccountTotal(accId),
      );
    }).toList();

    return SizedBox(
      height: 150.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Swiper(
              onIndexChanged: (index) {
                userData.selectAccount(index);
              },
              viewportFraction: 0.8,
              scale: 0.9,
              duration: 50,
              loop: false,
              itemCount: children.length,
              itemBuilder: (context, index) => children[index],
              pagination: SwiperPagination(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.all(0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
      return Container(
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 15.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'List of accounts',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AddAccountButton(),
                ],
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
      );
    });
  }
}

class AddAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) => OutlineButton(
        padding: EdgeInsets.all(8.0),
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
  }
}
