import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/dashboard_viewmodel.dart';
import 'package:snapsheetapp/ui/components/button/add_account_button.dart';
import 'package:snapsheetapp/ui/components/button/edit_accounts_button.dart';
import 'package:snapsheetapp/ui/components/button/select_all_button.dart';
import 'account_tile.dart';

class AccountsCarousel extends StatefulWidget {
  @override
  _AccountsCarouselState createState() => _AccountsCarouselState();
}

class _AccountsCarouselState extends State<AccountsCarousel> {
  @override
  Widget build(BuildContext context) {
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
              Consumer<DashboardViewModel>(
                builder: (context, model, child) {
//                  print('CAROUSEL');
//                  print(model.selectedAccountIndex);
                  return CarouselSlider(
                    carouselController: DashboardViewModel.controller,
                    items: makeAccountTiles(model),
                    options: CarouselOptions(
                      initialPage: model.selectedAccountIndex != -1 &&
                              model.selectedAccountIndex != null
                          ? model.selectedAccountIndex
                          : 0,
                      height: 55.0,
                      viewportFraction: 0.3,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      autoPlayAnimationDuration: Duration(milliseconds: 100),
                      onPageChanged: (index, manual) {
                        model.selectAccount(index);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> makeAccountTiles(DashboardViewModel model) {
    return model.accounts.map((acc) {
//      print("model.accounts.length = ${model.accounts.length}");
//      print("acc.uid = ${acc.uid}");
//      print("acc.index = ${acc.index}");
      return Opacity(
        opacity: model.isAccountSelected(acc) ? 1.0 : 0.5,
        child: AccountTile(
          index: acc.index,
          color: acc.color,
          title: acc.title,
          total: model.getSumFromAccount(acc),
        ),
      );
    }).toList();
  }
}
