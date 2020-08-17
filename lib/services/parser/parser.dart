abstract class Parser {
  /// Return the title of the shop in the receipt.
  String findTitle(List<String> input);

  /// Return the categoryId of the shop that is captured from the receipt.
  int findCategoryId();

  /// Return the DateTime of the receipt.
  DateTime findDate(String input);

  /// Return the cost of the receipt.
  double findCost(String input);
}
