import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/button/add_account_button.dart';
import 'package:snapsheetapp/screens/home/edit_order_accounts.dart';
import 'package:snapsheetapp/screens/home/rename_account_popup.dart';
import 'package:snapsheetapp/models/account.dart';
import 'package:snapsheetapp/models/user_data.dart';

import 'account_order_tile.dart';
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
    if (index != -1) controller.animateToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Provider<CarouselController>(
      create: (_) => controller,
      builder: (context, child) =>
          Consumer<UserData>(builder: (context, userData, child) {
        return Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                        MaterialButton(
                          visualDensity: VisualDensity.comfortable,
                          minWidth: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.white),
                          ),
                          child: Icon(
                            Icons.list,
                            size: 20.0,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, EditAccountsOrder.id);
                          },
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
      }),
    );
  }

  List<Widget> makeAccountTiles(UserData userData) {
    return userData.orderGetAccounts().map((e) {
      Account acc = userData.getThisAccount(e);
      int accIndex = acc.accIndex;
      return Opacity(
        opacity: accIndex == userData.selectedAccount ? 1.0 : 0.5,
        child: AccountTile(
          index: accIndex,
          color: e.color,
          title: e.title,
          count: userData.statsCountRecords(accIndex),
          total: userData.statsGetAccountTotal(accIndex),
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
        child: MaterialButton(
          visualDensity: VisualDensity.comfortable,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.blueAccent),
          ),
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
