import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/models/record.dart';

List<Record> demoRecords = [
  Record.demo("Carousel sales", 500, DateTime(2020, 4, 12), INCOME, 0, true),
  Record.demo("Steam Dota", 12, DateTime(2020, 4, 12), ENTERTAINMENT, 0),
  Record.demo("UNIQLO", 30, DateTime(2020, 5, 12), SHOPPING, 0),
  Record.demo("Mother's Day", 20, DateTime(2020, 5, 10), SHOPPING, 0),
  Record.demo("Sentosa Outing", 14.50, DateTime(2020, 2, 12), ENTERTAINMENT, 1),
  Record.demo(
      "Netflix Subscription", 12, DateTime(2020, 6, 1), ENTERTAINMENT, 0),
  Record.demo("Food & Beverage", 5.8, DateTime(2020, 5, 29), FOODDRINKS, 1),
  Record.demo("Dental check up", 30, DateTime(2020, 6, 3), HEALTH, 1),
  Record.demo("First Aid kit", 20, DateTime(2020, 3, 12), HEALTH, 2),
  Record.demo("Group outing", 15, DateTime(2020, 4, 5), ENTERTAINMENT, 2),
  Record.demo("Bus transport", 25, DateTime(2020, 5, 6), TRANSPORTATION, 2),
  Record.demo("CCA book", 16.75, DateTime(2020, 5, 3), EDUCATION, 2),
  Record.demo("Online course", 5.75, DateTime(2020, 5, 20), EDUCATION, 2),
  Record.demo("Teacher's Birthday Gift", 4, DateTime(2020, 4, 3), GIVING, 2),
  Record.demo("Hachi Tech", 49.8, DateTime(2020, 5, 17), ELECTRONICS, 0, false,
      hachiTech, true),
  Record.demo("Golden Village", 19, DateTime(2019, 4, 24), ENTERTAINMENT, 1,
      false, goldenVillage, true),
  Record.demo("Pepper Lunch", 22.9, DateTime(2020, 6, 8), FOODDRINKS, 0),
];

/// Demo Receipt Images url
String hachiTech =
    "https://firebasestorage.googleapis.com/v0/b/snapsheet-e7f7b.appspot.com/o/demo-receipts%2Fhachi-tech.jpg?alt=media&token=90803d65-edd6-4d85-aca0-28fc36ae2126";
String goldenVillage =
    "https://firebasestorage.googleapis.com/v0/b/snapsheet-e7f7b.appspot.com/o/demo-receipts%2Fgolden-village.jpg?alt=media&token=d8b0fa0f-1699-4009-aff5-dd53d940d28f";
