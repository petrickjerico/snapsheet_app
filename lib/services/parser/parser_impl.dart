import 'package:snapsheetapp/business_logic/default_data/shops.dart';
import 'package:snapsheetapp/services/parser/parser.dart';
import 'package:string_similarity/string_similarity.dart';

class ParserImpl implements Parser {
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

  String matchedName;

  /// Return the title of the shop in the receipt.
  String findTitle(List<String> input) {
    /// Remove Strings that are non alphabetical
    RegExp alphabetical = RegExp(r"^.*[a-zA-Z].*$");
    List<String> filtered =
        input.where((e) => alphabetical.hasMatch(e)).toList();

    /// Prepare the list of shop lowercased name
    List<String> shopNames = shops.keys.toList();

    /// Find the single word best match
    for (String word in filtered) {
      BestMatch match = StringSimilarity.findBestMatch(word, shopNames);
      Rating best = match.bestMatch;
      if (best.rating > 0.77) {
        matchedName = best.target;
        return shops[matchedName].title;
      }
    }

    /// Find the 2 words best match
    for (int i = 0; i < filtered.length - 1; i++) {
      String twoWords = filtered[i] + " " + filtered[i + 1];
      BestMatch match = StringSimilarity.findBestMatch(twoWords, shopNames);
      Rating best = match.bestMatch;
      if (best.rating > 0.7) {
        matchedName = best.target;
        return shops[matchedName].title;
      }
    }

    /// Find the 3 words best match
    for (int i = 0; i < filtered.length - 2; i++) {
      String threeWords =
          filtered[i] + " " + filtered[i + 1] + " " + filtered[i + 2];
      BestMatch match = StringSimilarity.findBestMatch(threeWords, shopNames);
      Rating best = match.bestMatch;
      if (best.rating > 0.7) {
        matchedName = best.target;
        return shops[matchedName].title;
      }
    }

    return "";
  }

  /// Return the categoryId of the shop that is captured from the receipt.
  int findCategoryId() {
    return matchedName != null ? shops[matchedName].categoryId : 0;
  }

  /// Return the DateTime of the receipt.
  DateTime findDate(String input) {
    for (Function parser in dateFormats) {
      DateTime parsed = parser(input);
      if (parsed != null) {
        return parsed;
      }
    }
    return DateTime.now();
  }

  /// Return the cost of the receipt.
  double findCost(String input) {
    RegExp alertWords = RegExp(r"(discount|change|coupon)");
    RegExp money = RegExp(r"\d+\.\d{2}");

    Iterable<RegExpMatch> matches = money.allMatches(input);

    if (matches.isEmpty) return 0;

    List<double> costs = [];
    for (RegExpMatch match in matches) {
      String cost = input.substring(match.start, match.end);
      costs.add(double.parse(cost));
    }

    costs.sort();
    List<double> reversed = costs.reversed.toSet().toList();

    return alertWords.hasMatch(input) ? reversed[1] : reversed[0];
  }

  /// List of various common date formats found in receipts
  List<Function> dateFormats = [ddmmyy, ddmmyyyy, ddmonyy, ddmonyyyy, yyyymmdd];

  static DateTime ddmmyy(String input) {
    RegExp date = RegExp(r"[0-3][0-9]/[0-1][0-9]/\d{2}");
    String match = date.stringMatch(input);
    if (match == null) return null;
    String strDate = "20" +
        match.substring(6, 8) +
        match.substring(3, 5) +
        match.substring(0, 2);
    return DateTime.parse(strDate);
  }

  static DateTime ddmmyyyy(String input) {
    RegExp date = RegExp(r"[0-3][0-9]/[0-1][0-9]/\d{4}");
    String match = date.stringMatch(input);
    if (match == null) return null;
    String strDate =
        match.substring(6, 10) + match.substring(3, 5) + match.substring(0, 2);
    return DateTime.parse(strDate);
  }

  static DateTime ddmonyy(String input) {
    RegExp date = RegExp(
        r"[0-3][0-9] (jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec) \d{2}");
    String match = date.stringMatch(input);
    if (match == null) return null;
    String strDate = "20" +
        match.substring(7, 9) +
        mthToMM[match.substring(3, 6)] +
        match.substring(0, 2);
    return DateTime.parse(strDate);
  }

  static DateTime ddmonyyyy(String input) {
    RegExp date = RegExp(
        r"[0-3][0-9] (jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec) \d{4}");
    String match = date.stringMatch(input);
    if (match == null) return null;
    String strDate = "20" +
        match.substring(7, 9) +
        mthToMM[match.substring(3, 6)] +
        match.substring(0, 2);
    return DateTime.parse(strDate);
  }

  static DateTime yyyymmdd(String input) {
    RegExp date = RegExp(r"\d{4}-[0-1][0-9]-[0-3][0-9]");
    String match = date.stringMatch(input);
    if (match == null) return null;
    return DateTime.parse(match.replaceAll(RegExp(r"/"), ""));
  }
}
