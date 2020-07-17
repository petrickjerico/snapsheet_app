import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_basemodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/services/scanner/scanner_impl.dart';
import 'package:http/http.dart' show get;

class ExpenseViewModel extends ChangeNotifier implements ExpenseBaseModel {
  UserData userData;
  List<Account> accounts;
  List<Category> categories;

  void init(UserData userData) {
    this.userData = userData;
    accounts = userData.accounts;
    categories = userData.categories;
  }

  Record tempRecord;
  Record editRecord;
  bool isEditing = false;
  bool isScanned = false;
  bool isOperated = false;
  String expression;

  File imageFile;
  ImagePicker _picker = ImagePicker();
  Scanner scanner = ScannerImpl();

  Future<void> imageToTempRecord() async {
    if (imageFile != null) {
      Map<String, dynamic> map = await scanner.getDataFromImage(imageFile);
      tempRecord.value = map['value'];
      tempRecord.dateTime = map['dateTime'];
      tempRecord.title = map['title'];
      tempRecord.categoryUid = categories[map['categoryId']].uid;
      tempRecord.imagePath = map['imagePath'];
      print("IMAGETOTEMP: $tempRecord");
    }
    notifyListeners();
  }

  int getAccountIndexFromTempRecord() {
    return accounts.firstWhere((acc) => acc.uid == tempRecord.accountUid).index;
  }

  int getCategoryIndexFromTempRecord() {
    return categories
        .firstWhere((cat) => cat.uid == tempRecord.categoryUid)
        .index;
  }

  void toggleScanned() {
    isScanned = !isScanned;
    notifyListeners();
  }

  void toggleOperated(bool isOperated) {
    this.isOperated = isOperated;
  }

  void setExpression(String expression) {
    this.expression = expression;
  }

  void addRecord() {
    if (!isEditing) {
      userData.addRecord(tempRecord);
    } else {
      userData.updateRecord(tempRecord);
      isEditing = false;
    }
    notifyListeners();
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Select"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  _openGallery(BuildContext context) async {
    var picture = await _picker.getImage(
        source: ImageSource.gallery, maxHeight: 500, maxWidth: 500);
    imageFile = File(picture.path);
    if (picture != null) {
      changeValue(0);
      print('changeValue(0) called.');
      toggleScanned();
    }
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await _picker.getImage(
        source: ImageSource.camera, maxHeight: 500, maxWidth: 500);
    imageFile = File(picture.path);
    if (picture != null) {
      changeValue(0);
      toggleScanned();
    }
    Navigator.of(context).pop();
  }

  void newRecord() {
    tempRecord = Record.newBlankRecord();
    tempRecord.accountUid = accounts.first.uid;
    tempRecord.categoryUid = categories.first.uid;
    notifyListeners();
  }

  void changeTempRecord(int recordIndex) {
    tempRecord = userData.records[recordIndex];
    editRecord = Record.of(tempRecord);
    isEditing = true;
    print("CHANGETEMP: $tempRecord");
    notifyListeners();
  }

  void undoEditRecord() {
    tempRecord.value = editRecord.value;
    tempRecord.categoryId = editRecord.categoryId;
    tempRecord.isIncome = editRecord.isIncome;
    tempRecord.dateTime = editRecord.dateTime;
    tempRecord.imagePath = editRecord.imagePath;
    notifyListeners();
  }

  void changeTitle(String newTitle) {
    tempRecord.title = newTitle;
    notifyListeners();
  }

  void changeValue(double newValue) {
    tempRecord.value = newValue;
    notifyListeners();
  }

  void changeDate(DateTime newDateTime) {
    tempRecord.dateTime = newDateTime;
    notifyListeners();
  }

  void changeCategory(int newCategoryId) {
    tempRecord.categoryUid = categories[newCategoryId].uid;
    notifyListeners();
  }

  void changeAccount(int newAccountIndex) {
    tempRecord.accountUid = accounts[newAccountIndex].uid;
    notifyListeners();
  }

  void changeImage(String newImagePath) {
    tempRecord.imagePath = newImagePath;
    notifyListeners();
  }

  void deleteImage() {
    tempRecord.imagePath = null;
    tempRecord.receiptURL = null;
    notifyListeners();
  }

  void deleteRecord() {
    userData.deleteRecord(tempRecord);
    if (isEditing) {
      isEditing = false;
    }
    notifyListeners();
  }

  bool hasImage() {
    return tempRecord.imagePath != null || tempRecord.receiptURL != null;
  }

  Future<void> exportImage() async {
    if (tempRecord.receiptURL != null) {
      var response = await get(tempRecord.receiptURL);
      await Share.file(
        'snapsheet',
        'snapsheet.png',
        response.bodyBytes,
        'image/png',
      );
    } else {
      File target = File(tempRecord.imagePath);
      final ByteData bytes = ByteData.view(target.readAsBytesSync().buffer);
      await Share.file(
        'snapsheet',
        'snapsheet.png',
        bytes.buffer.asUint8List(),
        'image/png',
      );
    }
  }
}
