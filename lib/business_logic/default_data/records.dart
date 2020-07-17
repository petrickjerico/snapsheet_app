import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/models/record.dart';

List<Record> demoRecords = [
  Record.unnamed("Carousel sales", 120, DateTime(2020, 4, 12), INCOME, 0, true),
  Record.unnamed("Steam Dota", 12, DateTime(2020, 4, 12), ENTERTAINMENT, 0),
  Record.unnamed("UNIQLO", 30, DateTime(2020, 5, 12), SHOPPING, 0),
  Record.unnamed("Mother's Day", 20, DateTime(2020, 5, 10), SHOPPING, 0),
  Record.unnamed(
      "Sentosa Outing", 14.50, DateTime(2020, 2, 12), ENTERTAINMENT, 1),
  Record.unnamed(
      "Netflix Subscription", 12, DateTime(2020, 6, 1), ENTERTAINMENT, 0),
  Record.unnamed("Food & Beverage", 5.8, DateTime(2020, 5, 29), FOODDRINKS, 1),
  Record.unnamed("Dental check up", 30, DateTime(2020, 6, 3), HEALTH, 1),
  Record.unnamed("First Aid kit", 20, DateTime(2020, 3, 12), HEALTH, 2),
  Record.unnamed("Group outing", 15, DateTime(2020, 4, 5), ENTERTAINMENT, 2),
  Record.unnamed("Bus transport", 25, DateTime(2020, 5, 6), TRANSPORTATION, 2),
  Record.unnamed("CCA book", 16.75, DateTime(2020, 5, 3), EDUCATION, 2),
  Record.unnamed("Online course", 5.75, DateTime(2020, 5, 20), EDUCATION, 2),
  Record.unnamed("Teacher's Birthday Gift", 4, DateTime(2020, 4, 3), GIVING, 2),
];
