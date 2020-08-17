import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'file:///C:/Users/jtedd/AndroidStudioProjects/snapsheet_app/lib/ui/views/accounts/account_order_tile.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/views/accounts/add_account_popup.dart';

class SelectAccountScreen extends StatelessWidget {
  static const String id = 'select_account_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageViewModel>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          textTheme: Theme.of(context).textTheme,
          iconTheme: Theme.of(context).iconTheme,
          elevation: 0,
          backgroundColor: Colors.transparent,
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
