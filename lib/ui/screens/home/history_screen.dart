import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/homepage/homepage_viewmodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/ui/components/button/rounded_button.dart';
import 'package:snapsheetapp/ui/components/empty_state.dart';
import 'package:snapsheetapp/ui/components/history_tile.dart';
import 'package:snapsheetapp/ui/config/colors.dart';
import 'package:snapsheetapp/ui/config/decoration.dart';
import 'package:snapsheetapp/ui/screens/sidebar/sidebar_menu.dart';

import 'add_account_popup.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userData, child) {
      return ChangeNotifierProvider<FilterData>(
        create: (context) => FilterData(userData),
        child: FilteredRecords(),
      );
    });
  }
}

class FilterData extends ChangeNotifier {
  UserData userData;
  List<Account> allAccounts;
  List<Account> accountsToMatch;
  List<Category> allCategories;
  List<Category> categoriesToMatch;
  List<Record> records;
  double minValue;
  double maxValue;
  DateTime earliest;
  DateTime latest;
  Record tempRecord;
  bool isActive;

  FilterData(UserData userData) {
    this.userData = userData;
    initData();
  }

  void initData() {
    try {
      allAccounts = userData.accounts;
      allCategories = userData.categories;
      records = List.of(userData.records);

      // Initialise every toMatches to include all first
      accountsToMatch = List.of(userData.accounts);
      categoriesToMatch = List.of(userData.categories);

      // Other data that are initialised without UserData.
      minValue = double.negativeInfinity;
      maxValue = double.infinity;
      earliest = DateTime.now();
      latest = DateTime.now().subtract(Duration(days: 1825)); // 5 years back
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void deleteRecord(Record rec) {
    records.remove(rec);
    tempRecord = rec;
    notifyListeners();
  }

  void undoDelete() {
    print("///// adding: " + tempRecord.toString());
    records.add(tempRecord);
    records.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    tempRecord = null;
    notifyListeners();
  }

  void toggleActive() {
    isActive = !isActive;
    notifyListeners();
  }
}

class FilteredRecords extends StatefulWidget {
  @override
  _FilteredRecordsState createState() => _FilteredRecordsState();
}

class _FilteredRecordsState extends State<FilteredRecords> {
  List<Record> filteredRecords;
  bool isActive = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final filterData = Provider.of<FilterData>(context);
    filteredRecords = filterData.records;
    print('didChangeDependencies() was called!');
    print(filteredRecords.length);
  }

  @override
  Widget build(BuildContext context) {
    int recordsCount = filteredRecords.length;
    return Scaffold(
      backgroundColor: kBlack,
      drawer: SidebarMenu(),
      body: recordsCount < 1
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
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final record = filteredRecords[index];
                          return HistoryTile(
                            record: record,
                            index: index,
                            color: Colors.white.withOpacity(0.8),
                            fromHistory: true,
                          );
                        },
                        itemCount: recordsCount,
                      ),
                    ),
                  ),
                ),
              ],
            ),
      appBar: AppBar(
        title: Text('RECORDS'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.filter,
                size: 20, color: isActive ? Colors.amber : Colors.white),
            onPressed: () {},
            splashColor: Colors.transparent,
          )
        ],
      ),
    );
  }
}
