import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'package:snapsheetapp/ui/components/button/add_account_button.dart';
import 'package:snapsheetapp/ui/components/button/edit_accounts_button.dart';
import 'package:snapsheetapp/ui/components/button/select_all_button.dart';
import 'package:snapsheetapp/ui/config/colors.dart';
import 'account_tile.dart';

class AccountsCarousel extends StatefulWidget {
  @override
  _AccountsCarouselState createState() => _AccountsCarouselState();
}

class _AccountsCarouselState extends State<AccountsCarousel> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageViewModel>(builder: (context, model, child) {
      String toShow = HomepageViewModel.selectedAccountIndex == -1
          ? ""
          : "${HomepageViewModel.selectedAccountIndex + 1 ?? "ALL"}/${model.accounts.length}";
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SelectAllButton(),
                  Text(
                    toShow,
                    textAlign: TextAlign.center,
                  ),
                  AddAccountButton(),
                ],
              ),
            ),
            Consumer<HomepageViewModel>(
              builder: (context, model, child) {
                int selectedIndex = HomepageViewModel.selectedAccountIndex;
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height: 65.0,
                      width: 142.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.chevron_left,
                            color: Colors.black54,
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                    CarouselSlider(
                      carouselController: HomepageViewModel.controller,
                      items: makeAccountTiles(model),
                      options: CarouselOptions(
                        initialPage:
                            selectedIndex != -1 && selectedIndex != null
                                ? selectedIndex
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
                        color: kNavyBlue,
                        total: model.currentExpensesTotal(),
                      ),
                      visible: selectedIndex == -1,
                    )
                  ],
                );
              },
            ),
            SizedBox(
              height: 3.0,
            ),
          ],
        ),
      );
    });
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
