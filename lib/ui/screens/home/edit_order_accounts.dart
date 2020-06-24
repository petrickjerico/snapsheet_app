import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/dashboard_viewmodel.dart';
import 'package:snapsheetapp/ui/components/account/account_order_tile.dart';
import 'package:snapsheetapp/ui/components/reorderable_list.dart';

import 'add_account_popup.dart';

class EditAccountsOrder extends StatefulWidget {
  static final String id = 'edit_order_accounts';
  @override
  _EditAccountsOrderState createState() => _EditAccountsOrderState();
}

class _EditAccountsOrderState extends State<EditAccountsOrder> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(builder: (context, model, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('LIST OF ACCOUNTS'),
        ),
        body: Container(
            color: Colors.black.withOpacity(0.8),
            child: Theme(
              data: ThemeData.dark().copyWith(accentColor: Colors.white),
              child: ReorderableListSimple(
                  handleSide: ReorderableListSimpleSide.Left,
                  handleIcon: Icon(Icons.reorder),
                  children: model.accounts.map((account) {
                    return AccountOrderTile(
                      index: account.index,
                      color: account.color,
                      title: account.title,
                      total: model.getSumFromAccount(account),
                    );
                  }).toList()),
            )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddAccountPopup(),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
