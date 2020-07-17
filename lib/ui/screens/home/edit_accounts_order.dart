import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
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
        int accountsCount = model.accounts.length;
        Widget body = accountsCount < 1
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
            : Column(
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
                        allowReordering: false,
                        handleSide: ReorderableListSimpleSide.Left,
                        handleIcon: Icon(
                          FontAwesomeIcons.bars,
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
              );
        return Scaffold(
          backgroundColor: kBlack,
          drawer: SidebarMenu(),
          body: body,
          appBar: AppBar(
            title: Text('LIST OF ACCOUNTS'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  print('pressed');
                },
                splashColor: Colors.transparent,
              )
            ],
          ),
        );
      },
    );
  }
}
