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
      FilterData filterData = FilterData(userData);
      return ChangeNotifierProvider<FilterData>(
        create: (context) => filterData,
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
  bool isActive = false;

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

  void toggleActivity(bool activity) {
    print("toggleActivity: " + activity.toString());
    isActive = activity;
    notifyListeners();
  }
}

class FilteredRecords extends StatefulWidget {
  @override
  _FilteredRecordsState createState() => _FilteredRecordsState();
}

class _FilteredRecordsState extends State<FilteredRecords> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FilterData>(builder: (context, filterData, child) {
      var filteredRecords = filterData.records;
      var isActive = filterData.isActive;
      print("isActive: " + isActive.toString());
      var recordsCount = filteredRecords.length;
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Visibility(
                    visible: isActive,
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.symmetric(horizontal: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.amberAccent,
                        ),
                        child: Text(
                          "FILTER APPLIED - tap for details",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          child: SimpleDialog(
                            title: Text("Filter Details"),
                            contentPadding: EdgeInsets.fromLTRB(24, 16, 16, 12),
                            children: <Widget>[
                              Text("accounts"),
                              Text("categories"),
                              Text("amount"),
                              Text("date"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton(
                                    child: Text("RESET"),
                                    onPressed: () {
                                      filterData.toggleActivity(false);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("NEW FILTER"),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider.value(
                                            value: filterData,
                                            builder: (context, child) =>
                                                FilterScreen(),
                                          ),
                                          fullscreenDialog: true,
                                        ),
                                      );
                                    },
                                    color: Colors.black,
                                    textColor: Colors.white,
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
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
            Visibility(
              visible: isActive,
              child: IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () {
                  filterData.toggleActivity(false);
                },
              ),
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.filter,
                size: 20,
                color: isActive ? Colors.amberAccent : Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider.value(
                      value: filterData,
                      builder: (context, child) => FilterScreen(),
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
              splashColor: Colors.transparent,
            )
          ],
        ),
      );
    });
  }
}

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FilterData>(
      builder: (context, filterData, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Filter Screen'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  filterData.toggleActivity(true);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
