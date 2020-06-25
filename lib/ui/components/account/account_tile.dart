import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/dashboard_viewmodel.dart';

class AccountTile extends StatelessWidget {
  AccountTile({Key key, this.index, this.color, this.title, this.total})
      : super(key: key);

  int index;
  Color color;
  String title;
  double total;

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(builder: (context, model, child) {
      return Consumer<CarouselController>(
          builder: (context, controller, child) {
        return GestureDetector(
          onTap: () {
            controller.animateToPage(index);
            model.selectAccount(index);
          },
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10.0),
            ),
            height: 50.0,
            width: 100.0,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    total.toStringAsFixed(2),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
