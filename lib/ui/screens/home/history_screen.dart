import 'package:animations/animations.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_iconpicker/Dialogs/DefaultDialog.dart';
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
    return FilteredRecords();
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
  bool showExpenses;
  bool showIncomes;
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

  bool isVisible(Record record) {
    bool matchesAcc =
        accountsToMatch.any((acc) => record.accountUid == acc.uid);
    bool matchesCtg =
        categoriesToMatch.any((ctg) => record.categoryUid == ctg.uid);
    bool matchesVal = minValue <= record.value && record.value <= maxValue;
    return matchesAcc && matchesCtg && matchesVal;
  }

  void resetFilter() {
    accountsToMatch = List.of(allAccounts);
    categoriesToMatch = List.of(allCategories);
    minValue = double.negativeInfinity;
    maxValue = double.infinity;
    toggleActivity(false);
    notifyListeners();
  }

  bool setMatches(
      List<Account> accs, List<Category> ctgs, double min, double max) {
    if (accs.isEmpty &&
        ctgs.isEmpty &&
        min == double.negativeInfinity &&
        max == double.infinity) {
      return false;
    } else {
      if (accs.isNotEmpty) accountsToMatch = accs;
      if (ctgs.isNotEmpty) categoriesToMatch = ctgs;
      minValue = min;
      maxValue = max;
      return true;
    }
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
                                      filterData.resetFilter();
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
                            return Visibility(
                              visible: filterData.isVisible(record),
                              child: HistoryTile(
                                record: record,
                                index: index,
                                color: Colors.white.withOpacity(0.8),
                                fromHistory: true,
                              ),
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
                  filterData.resetFilter();
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
  List<Account> filterAccounts = [];
  List<Category> filterCategories = [];
  double minValue = double.negativeInfinity;
  double maxValue = double.infinity;
  DateTime earliest =
      DateTime.now().subtract(Duration(days: 1825)); // 5 years back
  DateTime latest = DateTime.now();
  bool showIncomes = true;
  bool showExpenses = true;

  Widget _getAccountsChips() {
    return filterAccounts.isEmpty
        ? Text(
            "Tap to select accounts",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          )
        : Wrap(
            spacing: 5,
            children: filterAccounts
                .map(
                  (acc) => InputChip(
                    label: Text(acc.title),
                    backgroundColor: acc.color,
                    onDeleted: () {
                      setState(() {
                        filterAccounts.remove(acc);
                      });
                    },
                  ),
                )
                .toList(),
          );
  }

  Widget _accountsSelection() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Text(
                "Filter by accounts:",
                style: TextStyle(fontSize: 14),
              ),
            ),
            _getAccountsChips(),
          ],
        ),
      ),
      onTap: () {
        final filterData = Provider.of<FilterData>(context, listen: false);
        showDialog(
            context: context,
            builder: (context) {
              List<Account> tempAccs = filterAccounts;
              return AlertDialog(
                actions: <Widget>[
                  FlatButton(
                    child: Text("CANCEL"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text("SELECT ALL"),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: Text("APPLY"),
                    onPressed: () {
                      setState(() {
                        filterAccounts = List.of(tempAccs);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
                title: Text("Select accounts"),
                content: StatefulBuilder(
                  builder: (context, setState) {
                    return Wrap(
                        spacing: 5,
                        children: filterData.allAccounts
                            .map(
                              (acc) => InputChip(
                                  label: Text(acc.title),
                                  backgroundColor: tempAccs.contains(acc)
                                      ? acc.color
                                      : Colors.grey,
                                  onSelected: (value) {
                                    setState(() {
                                      if (!tempAccs.contains(acc)) {
                                        tempAccs.add(acc);
                                      } else {
                                        tempAccs.remove(acc);
                                      }
                                      tempAccs.sort(
                                          (a, b) => a.index.compareTo(b.index));
                                    });
                                  }),
                            )
                            .toList());
                  },
                ),
              );
            });
      },
    );
  }

  Widget _getCategoriesChips() {
    return filterCategories.isEmpty
        ? Text(
            "Tap to select accounts",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          )
        : Wrap(
            spacing: 5,
            children: filterCategories
                .map(
                  (ctg) => InputChip(
                    label: Text(ctg.title),
                    backgroundColor: ctg.color,
                    onDeleted: () {
                      setState(() {
                        filterCategories.remove(ctg);
                      });
                    },
                  ),
                )
                .toList(),
          );
  }

  Widget _categoriesSelection() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Text(
                "Filter by categories:",
                style: TextStyle(fontSize: 14),
              ),
            ),
            _getCategoriesChips(),
          ],
        ),
      ),
      onTap: () {
        final filterData = Provider.of<FilterData>(context, listen: false);
        showDialog(
            context: context,
            builder: (context) {
              List<Category> tempCtgs = filterCategories;
              return AlertDialog(
                actions: <Widget>[
                  FlatButton(
                    child: Text("CANCEL"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text("SELECT ALL"),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: Text("APPLY"),
                    onPressed: () {
                      setState(() {
                        filterCategories = List.of(tempCtgs);
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
                title: Text("Select accounts"),
                content: StatefulBuilder(
                  builder: (context, setState) {
                    return Wrap(
                        spacing: 5,
                        children: filterData.allCategories
                            .map(
                              (ctg) => InputChip(
                                  label: Text(ctg.title),
                                  backgroundColor: tempCtgs.contains(ctg)
                                      ? ctg.color
                                      : Colors.grey,
                                  onSelected: (value) {
                                    setState(() {
                                      if (!tempCtgs.contains(ctg)) {
                                        tempCtgs.add(ctg);
                                      } else {
                                        tempCtgs.remove(ctg);
                                      }
                                      tempCtgs.sort(
                                          (a, b) => a.index.compareTo(b.index));
                                    });
                                  }),
                            )
                            .toList());
                  },
                ),
              );
            });
      },
    );
  }

  Widget _valuesSelection() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                labelText: 'Amount from:',
                prefixText: '\$',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                minValue = double.parse(value);
              },
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: TextField(
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                labelText: 'Amount to:',
                prefixText: '\$',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                maxValue = double.parse(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _datesSelection() {
    return Container(
      color: Colors.white,
      height: 25,
    );
  }

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
                  print(minValue.toString());
                  print(maxValue.toString());
                  bool filterIsSet = filterData.setMatches(
                      filterAccounts, filterCategories, minValue, maxValue);
                  if (filterIsSet) {
                    filterData.toggleActivity(true);
                    Navigator.pop(context);
                  } else {
                    filterData.toggleActivity(false);
                    Navigator.pop(context);
                    Flushbar(
                      message: "No filter was set.",
                      icon: Icon(
                        Icons.info_outline,
                        size: 28.0,
                        color: Colors.blue[300],
                      ),
                      duration: Duration(seconds: 3),
                      leftBarIndicatorColor: Colors.blue[300],
                    )..show(context);
                  }
                },
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _accountsSelection(),
              _categoriesSelection(),
              _valuesSelection(),
              _datesSelection(),
            ],
          ),
        );
      },
    );
  }
}
