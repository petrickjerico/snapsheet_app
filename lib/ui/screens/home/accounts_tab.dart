import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/dashboard_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/ui/components/account/accounts_carousel.dart';
import 'package:snapsheetapp/ui/components/stats/statistics.dart';

class AccountsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    return ChangeNotifierProvider<DashboardViewModel>(
      create: (context) => DashboardViewModel(userData: userData),
      child: Container(
        color: Colors.black.withOpacity(0.8),
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
      ),
    );
  }
}
