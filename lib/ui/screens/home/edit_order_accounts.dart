import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/view_models/dashboard/homepage_viewmodel.dart';
import 'package:snapsheetapp/ui/components/account/account_order_tile.dart';
import 'package:snapsheetapp/ui/components/button/add_account_button.dart';
import 'package:snapsheetapp/ui/components/button/select_all_button.dart';
import 'package:snapsheetapp/ui/components/reorderable_list.dart';
import 'package:snapsheetapp/ui/config/config.dart';

import 'add_account_popup.dart';

class EditAccountsOrder extends StatefulWidget {
  static final String id = 'edit_order_accounts';
  @override
  _EditAccountsOrderState createState() => _EditAccountsOrderState();
}

class _EditAccountsOrderState extends State<EditAccountsOrder> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            color: Colors.black.withOpacity(0.8),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      AddAccountButton(),
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: Divider.createBorderSide(
                          context,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                    ),
                    child: ReorderableListSimple(
                      allowReordering: true,
                      handleSide: ReorderableListSimpleSide.Left,
                      handleIcon: Icon(
                        Icons.swap_vert,
                        size: 30.0,
                        color: Colors.white54,
                      ),
                      children: model.accounts.map(
                        (account) {
                          return AccountOrderTile(
                            index: account.index,
                            color: account.color,
                            title: account.title,
                            total: model.getSumFromAccount(account),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
