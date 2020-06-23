import 'dart:io';

abstract class ExportBaseModel {
  Future<String> processCSV();
  Future<File> targetFile();
  Future<void> exportCSV();
  void toggleExport(int index);
}
