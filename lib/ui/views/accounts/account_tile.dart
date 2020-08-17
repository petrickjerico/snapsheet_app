import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';

class AccountTile extends StatelessWidget {
  AccountTile({Key key, this.index, this.color, this.title, this.total})
      : super(key: key);

  int index;
  int tempIndex;
  Color color;
  String title;
  double total;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageViewModel>(builder: (context, model, child) {
      return GestureDetector(
        onTap: () {
          model.selectAccount(index);
          if (index != -1) {
            HomepageViewModel.syncController();
          }
        },
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: model.isAccountSelected(index) ? 1.0 : 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: 55.0,
                width: 100.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          total == 0 ? '0' : total.toStringAsFixed(2),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: model.isOverlaid(index),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: 55.0,
                width: 100.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          "ALL",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          model.currentExpensesTotal() == 0
                              ? '0'
                              : model.currentExpensesTotal().toStringAsFixed(2),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 18,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
