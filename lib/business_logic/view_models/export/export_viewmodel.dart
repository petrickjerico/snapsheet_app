import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/export/export_basemodel.dart';
import 'file:///C:/Users/jtedd/AndroidStudioProjects/snapsheet_app/lib/business_logic/view_models/user_data/user_data_impl.dart';

class ExportViewModel extends ChangeNotifier implements ExportBaseModel {
  final UserData userData;
  List<Record> records;
  List<Account> accounts;
  List<bool> isExport;
  File target;
  DateTime start;
  DateTime end;

  ExportViewModel({this.userData}) {
    records = userData.records;
    accounts = userData.accounts;
    isExport = List.generate(accounts.length, (_) => true);
    start = records.isEmpty ? DateTime.now() : records.last.dateTime;
    end = DateTime.now();
  }

  void changeDate(bool isStart, DateTime dateTime) {
    if (isStart) {
      _changeStartDate(dateTime);
    } else {
      _changeEndDate(dateTime);
    }
  }

  void _changeStartDate(DateTime dateTime) {
    start = dateTime;
    notifyListeners();
  }

  void _changeEndDate(DateTime dateTime) {
    end = dateTime;
    notifyListeners();
  }

  void toggleExport(index) {
    isExport[index] = !isExport[index];
    notifyListeners();
  }

  Future<void> exportCSV() async {
    Future<String> data = _processCSV();
    await Permission.storage.request();
    target = await _targetFile();
    File file = await _writeData(await data);
    final ByteData bytes = ByteData.view(file.readAsBytesSync().buffer);
    await Share.file(
      'snapsheet',
      'snapsheet.csv',
      bytes.buffer.asUint8List(),
      'text/csv',
    );
  }

  int getAccountIndexFromUid(String accountUid) {
    for (int i = 0; i < accounts.length; i++) {
      if (accounts[i].uid == accountUid) return i;
    }
  }

  Future<String> _processCSV() async {
    List<Record> filtered = [];
    for (Record record in records) {
      if (!isExport[getAccountIndexFromUid(record.accountUid)]) continue;
      if (record.dateTime.isAfter(end)) continue;
      if (record.dateTime.isBefore(start)) continue;
      filtered.add(record);
    }

    List<List<dynamic>> rows = List<List<dynamic>>();

    for (Record record in filtered) {
      List<dynamic> row = List();
      row.add(record.dateTime);
      row.add(record.title);
      row.add(record.value);
      row.add(userData.getThisAccount(record.accountUid).title);
      row.add(userData.getThisCategory(record.categoryUid).title);
      rows.add(row);
    }

    return ListToCsvConverter().convert(rows);
  }

  Future<File> _targetFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    String path = "$dir/snapsheet-${DateTime.now()}.csv";
    return File(path);
  }

  Future<File> _writeData(String data) async {
    return target.writeAsString(data);
  }
}
