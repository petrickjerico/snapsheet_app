import 'dart:io';

import 'package:csv/csv.dart';
import 'package:snapsheetapp/models/record.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Exporter {
  final List<Record> records;
  final List<String> accounts;
  final List<String> categoryTitles;
  final List<bool> isExport;
  File target;

  Exporter({this.records, this.accounts, this.categoryTitles, this.isExport});

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
      row.add(accounts[r.accountId]);
      row.add(categoryTitles[r.categoryId]);
      row.add(r.currency);
      rows.add(row);
    }

    return ListToCsvConverter().convert(rows);
  }

  Future<File> targetFile() async {
    String dir = (await DownloadsPathProvider.downloadsDirectory).path;
    int count = 0;
    String path = "$dir/snapsheet${count == 0 ? "" : "($count)"}.csv";
    bool duplicateExist = await File(path).exists();
    while (duplicateExist) {
      count++;
      path = "$dir/snapsheet${count == 0 ? "" : "($count)"}.csv";
      duplicateExist = await File(path).exists();
    }
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
