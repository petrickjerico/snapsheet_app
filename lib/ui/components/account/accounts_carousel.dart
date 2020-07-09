import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/homepage_viewmodel.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SelectAllButton(),
                SizedBox(
                  width: 5.0,
                ),
                AddAccountButton(),
              ],
            ),
          ),
          Consumer<HomepageViewModel>(builder: (context, model, child) {
            return Stack(
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
                  carouselController: HomepageViewModel.controller,
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
                ),
                Visibility(
                  child: AccountTile(
                    index: -1,
                    title: "ALL",
                    color: Colors.black,
                    total: model.currentExpensesTotal(),
                  ),
                  visible: model.selectedAccountIndex == -1,
                )
              ],
            );
          }),
        ],
      ),
    );
  }

  List<Widget> makeAccountTiles(HomepageViewModel model) {
    return model.accounts.map(
      (acc) {
        return Opacity(
          opacity: model.isAccountSelected(acc) ? 1.0 : 0.5,
          child: AccountTile(
            index: acc.index,
            color: acc.color,
            title: acc.title,
            total: model.getSumFromAccount(acc),
          ),
        );
      },
    ).toList();
  }
}
