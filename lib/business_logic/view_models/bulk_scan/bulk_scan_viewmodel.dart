import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/bulk_scan/bulk_scan_basemodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data/user_data_impl.dart';
import 'package:snapsheetapp/services/scanner/scanner_impl.dart';

class BulkScanViewModel extends ChangeNotifier implements BulkScanBaseModel {
  UserData userData;

  List<Asset> assets = List<Asset>();
  List<Account> accounts;
  List<File> images = [];
  List<Record> records = [];
  List<bool> isConfirmed = [];
  int counter = 0;
  Scanner scanner;
  String selectedAccountUid;

  /// Initialize the model with UserData.
  void init(UserData userData) {
    this.userData = userData;
    accounts = userData.accounts;
    scanner = ScannerImpl();
  }

  /// Loads the image receipts that the user has chosen.
  Future<void> loadAssets() async {
    List<Asset> resultList;
    try {
      resultList = await MultiImagePicker.pickImages(maxImages: 300);
    } on Exception catch (e) {
      print(e.toString());
    }
    assets = resultList;
  }

  /// Process the loaded image receipts into Records.
  Future<void> processImages() async {
    await _assetsToImages();
    await _imagesToRecords();
    scanner.clearResources();
  }

  /// Convert assets selected by user to images for processing
  Future<void> _assetsToImages() async {
    images.clear();
    final directory = await getApplicationDocumentsDirectory();
    String path;
    for (Asset asset in assets) {
      ByteData byteData = await asset.getByteData();
      path = '${directory.path}/what${counter++}';
      final buffer = byteData.buffer;
      File image = await File(path).writeAsBytes(
          buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      images.add(image);
    }
  }

  /// Convert images selected by user to records
  Future<void> _imagesToRecords() async {
    records.clear();
    for (File image in images) {
      Map<String, dynamic> map = await scanner.getDataFromImage(image);
      Record record = Record.fromReceipt(
        title: map['title'],
        value: map['value'],
        dateTime: map['dateTime'],
        categoryUid: userData.categories[map['categoryId']].uid,
        accountUid: selectedAccountUid,
        imagePath: image.path,
      );
      print(record.toString());
      records.add(record);
      isConfirmed.add(false);
    }
  }

  /// Add all confirmed receipts.
  void addConfirmedReceipts() {
    for (int i = 0; i < records.length; i++) {
      if (!isConfirmed[i]) continue;
      userData.addRecord(records[i]);
    }
  }

  /// Update a particular receipt's attribute with the new value.
  /// The first argument recordId refers to a particular receipt.
  void changeValue(int recordId, double newValue) {
    records[recordId].value = newValue;
    notifyListeners();
  }

  void changeTitle(int recordId, String newTitle) {
    records[recordId].title = newTitle;
    notifyListeners();
  }

  void changeDate(int recordId, DateTime newDateTime) {
    records[recordId].dateTime = newDateTime;
    notifyListeners();
  }

  void changeCategory(int recordId, int newCategoryId) {
    records[recordId].categoryUid = userData.categories[newCategoryId].uid;
    notifyListeners();
  }
}
