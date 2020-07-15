import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/ui/components/button/rounded_button.dart';
import 'package:snapsheetapp/ui/components/empty_state.dart';
import 'package:snapsheetapp/ui/components/history_tile.dart';
import 'package:snapsheetapp/ui/config/colors.dart';
import 'package:snapsheetapp/ui/config/decoration.dart';

import 'add_account_popup.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageViewModel>(
      builder: (context, model, child) {
        int recordsCount = model.records.length;
        print(recordsCount);
        print(model.records);
        return recordsCount < 1
            ? EmptyState(
                icon: Icon(
                  FontAwesomeIcons.solidMeh,
                  color: Colors.white30,
                  size: 100.0,
                ),
                messageColor: Colors.white30,
                message: 'Nothing to show here yet. \n'
                    'Create an account and start adding records.',
              )
            : Column(
                children: <Widget>[
                  FilterSection(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final record = model.records[index];
                            return HistoryTile(
                              record: record,
                              index: index,
                              color: Colors.white.withOpacity(0.8),
                            );
                          },
                          itemCount: model.records.length,
                        ),
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}

class FilterSection extends StatefulWidget {
  @override
  _FilterSectionState createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black.withOpacity(0.4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Filters',
                style: TextStyle(color: Colors.white),
              ),
              MaterialButton(
                visualDensity: VisualDensity.comfortable,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.white),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.filter,
                      size: 15.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'APPLY FILTER',
                      style: TextStyle(fontSize: 13.0, color: Colors.white),
                    ),
                  ],
                ),
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
              ),
            ],
          ),
          Divider(
            thickness: 1.0,
            color: Colors.white54,
          ),
          Text(
            'Categories: ',
            style: TextStyle(color: Colors.white),
          ),
          CategoryIcons(),
          Text(
            'Accounts: ',
            style: TextStyle(color: Colors.white),
          ),
          AccountIcons(),
        ],
      ),
    );
  }
}

class AccountIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageViewModel>(builder: (context, model, child) {
      return Wrap(
        spacing: 5.0,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        direction: Axis.horizontal,
        children: model.accounts
            .map((account) => Chip(
                  visualDensity: VisualDensity.compact,
                  label: Text(account.title),
                  backgroundColor: account.color,
                  labelStyle: TextStyle(color: Colors.white),
                ))
            .toList(),
      );
    });
  }
}

class CategoryIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Wrap(
        spacing: 5.0,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        direction: Axis.horizontal,
        children: categories
            .map(
              (category) => CircleAvatar(
                radius: 15,
                backgroundColor: category.color.withOpacity(0.2),
                child: IconTheme(
                  data: IconThemeData(color: category.color, size: 10),
                  child: FaIcon(category.icon.icon),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
