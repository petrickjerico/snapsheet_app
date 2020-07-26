import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'package:snapsheetapp/ui/components/account/account_order_tile.dart';
import 'package:snapsheetapp/ui/config/colors.dart';
import 'package:snapsheetapp/ui/config/decoration.dart';
import 'package:snapsheetapp/ui/screens/home/add_account_popup.dart';

class SelectAccountScreen extends StatelessWidget {
  static const String id = 'select_account_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageViewModel>(builder: (context, model, child) {
      return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kHomepageBackgroundTransparency,
          title: Text('ACCOUNTS'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: AddAccountPopup(),
                  ),
                  shape: kBottomSheetShape,
                );
              },
            )
          ],
        ),
        body: ListView.builder(
          itemCount: model.accounts.length,
          itemBuilder: (context, index) {
            Account account = model.accounts[index];
            return AccountOrderTile(
              index: account.index,
              color: account.color,
              title: account.title,
              total: model.getSumFromAccount(account),
              isSelectAccountScreen: true,
            );
          },
        ),
      );
    });
  }
}
