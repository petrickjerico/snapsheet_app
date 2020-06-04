import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snapsheetapp/models/record.dart';

import 'account.dart';
import 'category.dart';

class UserData extends ChangeNotifier {
  List<Account> _accounts = [
    Account('Account 1'),
    Account('Account 2'),
    Account('Account 3'),
  ];

  List<Category> _categories = [
    Category(
      'Food & Beverage',
      Icon(FontAwesomeIcons.utensils),
    ),
    Category(
      'Transportation',
      Icon(FontAwesomeIcons.shuttleVan),
    ),
    Category(
      'Fashion',
      Icon(FontAwesomeIcons.shoppingBag),
    ),
    Category(
      'Movies',
      Icon(FontAwesomeIcons.film),
    ),
    Category(
      'Medicine',
      Icon(FontAwesomeIcons.pills),
    ),
    Category(
      'Groceries',
      Icon(FontAwesomeIcons.shoppingCart),
    ),
    Category(
      'Games',
      Icon(FontAwesomeIcons.gamepad),
    ),
    Category(
      'Movies',
      Icon(FontAwesomeIcons.film),
    ),
    Category(
      'Recreation',
      Icon(FontAwesomeIcons.umbrellaBeach),
    ),
    Category(
      'Lodging',
      Icon(FontAwesomeIcons.hotel),
    ),
  ];

  List<Record> _records = [];

  List<Account> get accounts {
    return _accounts;
  }

  List<Category> get categories {
    return _categories;
  }

  List<Record> get records {
    return _records;
  }

  int get recordsCount {
    return _records.length;
  }

  void updateRecords() {
    List<Record> records = [];
    accounts.forEach((account) => records.addAll(account.records));
    records.sort((a, b) => a.date.compareTo(b.date));
    _records = records;
  }

  void addExpenseToAccount(Record rec, Account acc) {
    if (rec.title == "Untitled Record") {
      rec.rename(rec.category.categoryTitle);
    }
    int index = _accounts.indexWhere((element) => element.equals(acc));

    print(_accounts[index]);
    _accounts[index].add(rec);
    print(_accounts[index]);
    updateRecords();

    notifyListeners();
    print('User Data updated!');
  }

  void addCategory(String categoryTitle) {
    _categories.add(Category(categoryTitle, Icon(Icons.category)));
    notifyListeners();
  }
}
