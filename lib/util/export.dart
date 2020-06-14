import 'dart:io';

import 'package:csv/csv.dart';
import 'package:snapsheetapp/models/account.dart';
import 'package:snapsheetapp/models/category.dart';
import 'package:snapsheetapp/models/record.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Exporter {
  final List<Record> records;
  final List<Account> accounts;
  final List<Category> categories;
  List<bool> isExport;
  File target;

  Exporter(this.records, this.accounts, this.categories) {
    isExport = List<bool>.filled(accounts.length, true, growable: false);
  }

  int get accountCount => accounts.length;

  void toggleExport(index) {
    isExport[index] = !isExport[index];
  }

  Future<void> exportCSV() async {
    Future<String> data = processCSV();
    await Permission.storage.request();
    target = await targetFile();
    File file = await writeData(await data);
  }

  Future<String> processCSV() async {
    List<Record> filtered =
        records.where((e) => isExport[e.accountId]).toList();

    List<List<dynamic>> rows = List<List<dynamic>>();

    for (Record r in filtered) {
      List<dynamic> row = List();
      row.add(r.date);
      row.add(r.title);
      row.add(r.value);
      row.add(accounts[r.accountId].title);
      row.add(categories[r.categoryId].title);
      row.add(r.currency);
      rows.add(row);
    }

    return ListToCsvConverter().convert(rows);
  }

  Future<File> targetFile() async {
    String dir = (await DownloadsPathProvider.downloadsDirectory).path;
    String path = "$dir/snapsheet-${DateTime.now()}.csv";
    return File(path);
  }

  Future<String> readData(String path) async {
    final file = File(path);
    String body = await file.readAsString();
  }

  Future<File> writeData(String data) async {
    return target.writeAsString(data);
  }
}
