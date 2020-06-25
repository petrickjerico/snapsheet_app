import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/export/export_basemodel.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data_impl.dart';

class ExportViewModel extends ChangeNotifier implements ExportBaseModel {
  UserData userData;
  List<Record> records;
  List<Account> accounts;
  List<bool> isExport;
  File target;

  void init(UserData userData) {
    print('init from exportviewmodel');
    records = userData.records;
    accounts = userData.accounts;
    isExport = List.generate(accounts.length, (_) => true);
  }

  void toggleExport(index) {
    print(isExport);
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

  Future<String> _processCSV() async {
    List<Record> filtered =
        records.where((e) => isExport[records.indexOf(e)]).toList();

    List<List<dynamic>> rows = List<List<dynamic>>();

    for (Record record in filtered) {
      List<dynamic> row = List();
      row.add(record.dateTime);
      row.add(record.title);
      row.add(record.value);
      row.add(userData.getThisAccount(record.accountUid).title);
      row.add(categories[record.categoryId].title);
      rows.add(row);
    }

    return ListToCsvConverter().convert(rows);
  }

  Future<File> _targetFile() async {
    String dir = (await DownloadsPathProvider.downloadsDirectory).path;
    String path = "$dir/snapsheet-${DateTime.now()}.csv";
    return File(path);
  }

  Future<File> _writeData(String data) async {
    return target.writeAsString(data);
  }
}
