import 'package:string_similarity/string_similarity.dart';

class Parser {
  static var mthToMM = {
    'jan': '01',
    'feb': '02',
    'mar': '03',
    'apr': '04',
    'may': '05',
    'jun': '06',
    'jul': '07',
    'aug': '08',
    'sep': '09',
    'oct': '10',
    'nov': '11',
    'dec': '12'
  };

  List<String> shops = [
    "4fingers",
    "cold storage",
    "fairprice",
    "grab",
    "grabpay",
    "grabfood",
    "hachi tech",
    "kfc",
    "koi",
    "mcdonald's",
    "paylah",
    "paynow",
    "starbucks",
    "monster curry",
  ];

  String findBestMatch(String input) {
    BestMatch match = StringSimilarity.findBestMatch(input, shops);
  }

  DateTime findDate(String input) {
    for (Function parser in parsers) {
      DateTime parsed = parser(input);
      if (parsed != null) {
        return parsed;
      }
    }
  }

  List<Function> parsers = [ddmmyy, ddMonyy, yyyymmdd];

  static DateTime ddmmyy(String input) {
    RegExp date = RegExp(r"\d{2}/\d{2}/\d{2,4}");
    String match = date.stringMatch(input);
    if (match == null) return null;
    String strDate;
    if (match.length == 8) {
      // DDMMYY
      strDate = "20" +
          match.substring(6, 8) +
          match.substring(3, 5) +
          match.substring(0, 2);
    } else {
      // DDMMYYYY
      strDate = match.substring(6, 10) +
          match.substring(3, 5) +
          match.substring(0, 2);
    }
    return DateTime.parse(strDate);
  }

  static DateTime ddMonyy(String input) {
    RegExp date = RegExp(r"\d{2} \w{3} \d{2,4}");
    String match = date.stringMatch(input);
    if (match == null) return null;
    String strDate;
    if (match.length == 9) {
      // DDMMYY
      strDate = "20" +
          match.substring(7, 9) +
          mthToMM[match.substring(3, 6)] +
          match.substring(0, 2);
    } else {
      // DDMMYYYY
      strDate = match.substring(7, 11) +
          mthToMM[match.substring(3, 6)] +
          match.substring(0, 2);
    }
    return DateTime.parse(strDate);
  }

  static DateTime yyyymmdd(String input) {
    RegExp date = RegExp(r"\d{4}-\d{2}-\d{2}");
    String match = date.stringMatch(input);
    if (match == null) return null;
    return DateTime.parse(match.replaceAll(RegExp(r"/"), ""));
  }
}