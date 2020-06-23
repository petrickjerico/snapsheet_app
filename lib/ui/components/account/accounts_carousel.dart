import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/button/add_account_button.dart';
import 'package:snapsheetapp/components/button/edit_accounts_button.dart';
import 'package:snapsheetapp/components/button/select_all_button.dart';
import 'package:snapsheetapp/screens/home/edit_order_accounts.dart';
import 'package:snapsheetapp/screens/home/rename_account_popup.dart';
import 'package:snapsheetapp/models/account.dart';
import 'package:snapsheetapp/models/user_data.dart';

import 'account_order_tile.dart';
import 'account_tile.dart';
import '../../screens/home/add_account_popup.dart';

class AccountsCarousel extends StatefulWidget {
  @override
  _AccountsCarouselState createState() => _AccountsCarouselState();
}

class _AccountsCarouselState extends State<AccountsCarousel> {
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
                        EditAccountsButton(),
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
                          Account target = userData.accounts[index];
                          userData.selectAccount(target.id);
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
      Account acc = userData.getThisAccount(e.id);
      int accIndex = acc.id;
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
