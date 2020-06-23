import 'dart:io';

abstract class Scanner {
  Future<Map<String, dynamic>> getDataFromImage(File imageFile);
  void clearResources();
}
