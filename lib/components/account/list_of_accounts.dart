import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/button/add_account_button.dart';
import 'package:snapsheetapp/screens/home/rename_account_popup.dart';
import 'package:snapsheetapp/models/account.dart';
import 'package:snapsheetapp/models/user_data.dart';

import 'account_tile.dart';
import '../../screens/home/add_account_popup.dart';

class ListOfAccounts extends StatefulWidget {
  @override
  _ListOfAccountsState createState() => _ListOfAccountsState();
}

class _ListOfAccountsState extends State<ListOfAccounts> {
  static final CarouselController controller = CarouselController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var userData = Provider.of<UserData>(context);
    var index = userData.selectedAccount;
    var orderedList = userData.accountsOrder;
    if (index != -1) controller.animateToPage(orderedList[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Your accounts',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      SelectAllButton(),
                      SizedBox(
                        width: 5.0,
                      ),
                      AddAccountButton(),
                      SizedBox(
                        width: 5.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 70.0,
                    width: 142.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.chevron_left,
                          color: Colors.white54,
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.white54,
                        ),
                      ],
                    )),
                CarouselSlider(
                  carouselController: controller,
                  items: makeAccountTiles(userData),
                  options: CarouselOptions(
                      initialPage: userData.selectedAccount != -1
                          ? userData.selectedAccount
                          : 0,
                      height: 55.0,
                      viewportFraction: 0.3,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      autoPlayAnimationDuration: Duration(milliseconds: 100),
                      onPageChanged: (index, manual) {
                        userData.selectAccount(index);
                      }),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

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

  List<Widget> makeAccountTiles(UserData userData) {
    return userData.orderedGetAccounts().map((e) {
      int accId = userData.accounts.indexOf(e);
      return Opacity(
        opacity: accId == userData.selectedAccount ? 1.0 : 0.5,
        child: AccountTile(
          index: accId,
          color: e.color,
          title: e.title,
          count: userData.statsCountRecords(accId),
          total: userData.statsGetAccountTotal(accId),
        ),
      );
    }).toList();
  }
}

class SelectAllButton extends StatelessWidget {
  const SelectAllButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, userData, child) => Visibility(
        visible: userData.selectedAccount != -1,
        child: OutlineButton(
          visualDensity: VisualDensity.comfortable,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          borderSide: BorderSide(color: Colors.blueAccent),
          child: Text(
            'SELECT ALL',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
          onPressed: () {
            userData.selectAccount(-1);
            for (Account acc in userData.accounts) {
              acc.isSelected = true;
            }
          },
        ),
      ),
    );
  }
}
