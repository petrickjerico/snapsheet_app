import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/homepage_viewmodel.dart';
import 'package:snapsheetapp/ui/components/account/accounts_carousel.dart';
import 'package:snapsheetapp/ui/components/stats/statistics.dart';
import 'package:snapsheetapp/ui/config/colors.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageViewModel>(
      builder: (context, model, child) {
        return Container(
          color: kHomepageBackgroundTransparency,
          child: Column(
            children: <Widget>[
              AccountsCarousel(),
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Statistics(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
