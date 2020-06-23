import 'dart:io';

abstract class ExportBaseModel {
  Future<void> exportCSV();
  void toggleExport(int index);
}
