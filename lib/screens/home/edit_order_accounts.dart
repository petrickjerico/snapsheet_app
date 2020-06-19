import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/components/account/account_order_tile.dart';
import 'package:snapsheetapp/components/account/account_tile.dart';
import 'package:snapsheetapp/components/reorderable_list.dart';
import 'package:snapsheetapp/models/user_data.dart';
import 'package:snapsheetapp/screens/home/add_account_popup.dart';

class EditAccountsOrder extends StatefulWidget {
  static final String id = 'edit_order_accounts';
  @override
  _EditAccountsOrderState createState() => _EditAccountsOrderState();
}

class _EditAccountsOrderState extends State<EditAccountsOrder> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
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
                  handleIcon: Icon(Icons.reorder),
                  children: userData.accounts.map((e) {
                    int accId = userData.accounts.indexOf(e);
                    return AccountOrderTile(
                      index: accId,
                      color: e.color,
                      title: e.title,
                      count: userData.statsCountRecords(accId),
                      total: userData.statsGetAccountTotal(accId),
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
