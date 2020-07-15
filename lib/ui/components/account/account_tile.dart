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
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 60.0,
          width: 100.0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Flexible(
                  child: Text(
                    total == 0 ? '0' : total.toStringAsFixed(2),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
