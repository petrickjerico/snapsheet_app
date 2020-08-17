import 'dart:io';

abstract class Scanner {
  /// Return the data captured from a receipt image in JSON format
  Future<Map<String, dynamic>> getDataFromImage(File imageFile);

  /// Clear resources after using the scanner
  void clearResources();
}
