abstract class ExportBaseModel {
  void changeDate(bool isStart, DateTime dateTime);
  void toggleExport(int index);
  Future<void> exportCSV();
}
