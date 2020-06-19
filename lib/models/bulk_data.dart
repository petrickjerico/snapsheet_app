import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snapsheetapp/models/account.dart';
import 'package:snapsheetapp/models/category.dart';
import 'package:snapsheetapp/models/record.dart';

class BulkData extends ChangeNotifier {
  Record _tempRecord;
  bool _isEditing = false;
  bool _isScanned = false;

  List<Category> _categories = [
    Category('Food & Drinks', Icon(FontAwesomeIcons.utensils), Colors.red),
    Category(
        'Transportation', Icon(FontAwesomeIcons.shuttleVan), Colors.blueGrey),
    Category(
        'Shopping', Icon(FontAwesomeIcons.shoppingBag), Colors.lightBlueAccent),
    Category('Entertainment', Icon(FontAwesomeIcons.glassCheers),
        Colors.deepPurpleAccent),
    Category('Health', Icon(FontAwesomeIcons.pills), Colors.indigoAccent),
    Category('Education', Icon(FontAwesomeIcons.graduationCap), Colors.orange),
    Category('Electronics', Icon(FontAwesomeIcons.phone), Colors.teal),
    Category(
        'Income', Icon(FontAwesomeIcons.moneyBill), Colors.amberAccent, true),
    Category('Others', Icon(Icons.category), Colors.black)
  ];

  List<Record> _records = [];

  List<Record> get records => _records;

  int get recordsCount => _records.length;

  int get categoriesCount => _categories.length;

  List<Category> get categories => _categories;

  Record get tempRecord => _tempRecord;

  bool get isEditing => _isEditing;

  bool get isScanned => _isScanned;

  void toggleScanned() {
    _isScanned = !_isScanned;
  }

  void addRecord() {
    if (!_isEditing) {
      records.add(_tempRecord);
    }

    if (_isEditing) {
      _isEditing = false;
    }

    notifyListeners();
  }

  void addCategory(String categoryTitle, Icon icon) {
    _categories.add(Category(categoryTitle, icon, Colors.black));
    notifyListeners();
  }

  void newRecord() {
    _tempRecord =
        new Record("", 0, DateTime.now(), Record.catId, Record.accId, "SGD");
    notifyListeners();
  }

  void changeCategory(int catId) {
    _tempRecord.categoryId = catId;
    notifyListeners();
  }

  void changeValue(double newValue) {
    _tempRecord.value = newValue;
    notifyListeners();
  }

  void changeTempRecord(int recordIndex) {
    _tempRecord = _records[recordIndex];
    _isEditing = true;
    notifyListeners();
  }

  void changeImage(File imageFile) {
    _tempRecord.image = imageFile;
    notifyListeners();
  }

  void changeTitle(String newTitle) {
    _tempRecord.title = newTitle;
    notifyListeners();
  }

  void changeDate(DateTime newDate) {
    _tempRecord.date = newDate;
    notifyListeners();
  }
}
