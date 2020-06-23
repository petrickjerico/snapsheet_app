import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/expense/expense_basemodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';
import 'package:snapsheetapp/services/scanner/scanner_impl.dart';

class ExpenseViewModel extends ChangeNotifier implements ExpenseBaseModel {
  Record tempRecord;
  final UserData userData;
  File imageFile;
  ImagePicker _picker = ImagePicker();
  Scanner scanner = ScannerImpl();

  ExpenseViewModel(this.userData);

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
    var picture = await _picker.getImage(source: ImageSource.gallery);
    imageFile = File(picture.path);
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await _picker.getImage(source: ImageSource.camera);
    imageFile = File(picture.path);
    Navigator.of(context).pop();
  }

  void setTempRecord(Record record) {
    tempRecord = record;
  }

  void changeTitle(String newTitle) {
    tempRecord.title = newTitle;
  }

  void changeValue(double newValue) {
    tempRecord.value = newValue;
  }

  void changeDate(DateTime newDateTime) {
    tempRecord.dateTime = newDateTime;
  }

  void changeCategory(int newCategoryId) {
    tempRecord.categoryId = newCategoryId;
  }

  void changeAccount(int newAccountId) {
    tempRecord.accountId = newAccountId;
  }

  void changeImage(File imageFile) {
    tempRecord.image = imageFile;
  }
}
