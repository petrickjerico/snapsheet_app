import 'package:string_similarity/string_similarity.dart';

class Parser {
  var similarity = StringSimilarity.compareTwoStrings('french', 'quebec');
  var matches =
      StringSimilarity.findBestMatch('healed', ['edward', 'sealed', 'theatre']);
//testing
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
    return match.bestMatch.rating > 0.7
        ? match.bestMatch.target + ":" + match.bestMatch.rating.toString()
        : "";
  }
}
