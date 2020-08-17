abstract class ExportBaseModel {
  /// Change the starting or ending date range.
  void changeDate(bool isStart, DateTime dateTime);

  /// Toggle whether the account at accountIndex should be exported or not.
  void toggleExport(int accountIndex);

  /// Convert all the records within the date range into CSV file.
  /// Export the CSV file using third party app.
  Future<void> exportCSV();
}
