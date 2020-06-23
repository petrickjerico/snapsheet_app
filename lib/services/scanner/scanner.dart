import 'dart:io';

abstract class Scanner {
  Map<String, dynamic> extractDataFromTxt(List<String> txt);
  Future<List<String>> txtListFromImage(File imageFile);
  void clearResources();
}
