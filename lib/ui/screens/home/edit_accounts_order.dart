import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'package:snapsheetapp/ui/components/account/account_order_tile.dart';
import 'package:snapsheetapp/ui/components/button/add_account_button.dart';
import 'package:snapsheetapp/ui/components/button/select_all_button.dart';
import 'package:snapsheetapp/ui/components/empty_state.dart';
import 'package:snapsheetapp/ui/components/reorderable_list.dart';
import 'package:snapsheetapp/ui/config/config.dart';
import 'package:snapsheetapp/ui/screens/expense/expense_screen.dart';
import 'package:snapsheetapp/ui/screens/sidebar/sidebar_menu.dart';

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
        List<Account> accounts = List.of(model.accounts);
        int accountsCount = accounts.length;
        return Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          backgroundColor: kBlack,
          drawer: SidebarMenu(),
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
          body: accountsCount < 1
              ? EmptyState(
                  onTap: () {
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
                  messageColor: Colors.white30,
                  message: 'There is no account yet.\n'
                      'Tap to create one.',
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.white30,
                    size: 120.0,
                  ),
                )
              : ReorderableListSimple(
                  allowReordering: true,
                  handleSide: ReorderableListSimpleSide.Left,
                  handleIcon: Icon(
                    Icons.reorder,
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
                        isSelectAccountScreen: false,
                      );
                    },
                  ).toList(),
                  onReorder: (oldIndex, newIndex) =>
                      model.updateAccountIndex(oldIndex, newIndex),
                ),
        );
      },
    );
  }
}
