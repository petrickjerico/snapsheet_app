import 'package:snapsheetapp/business_logic/models/models.dart';

/// 0 - f&b
/// 1 - transportation
/// 2 - shopping
/// 3 - entertainment
/// 4 - health
/// 5 - education
/// 6 - electronic
/// 7 - income
/// 8 - giving
/// 9 - others
const FOODDRINKS = 0;
const TRANSPORTATION = 1;
const SHOPPING = 2;
const ENTERTAINMENT = 3;
const HEALTH = 4;
const EDUCATION = 5;
const ELECTRONICS = 6;
const GIVING = 7;
const INCOME = 8;
const OTHERS = 9;

// Updated as of 3rd July

Map<String, Shop> shops = {
  "4fingers":
      Shop(lowercase: '4fingers', title: '4Fingers', categoryId: FOODDRINKS),
  "ac kafe":
      Shop(lowercase: 'ac kafe', title: 'AC.Kafe', categoryId: FOODDRINKS),
  "ace": Shop(lowercase: "ace", title: "ace.", categoryId: SHOPPING),
  "action city": Shop(
      lowercase: "action city", title: "Action City", categoryId: SHOPPING),
  "adidas": Shop(lowercase: "adidas", title: 'Adidas', categoryId: SHOPPING),
  "american tourister": Shop(
      lowercase: "american tourister",
      title: "American Tourister",
      categoryId: SHOPPING),
  "anello": Shop(lowercase: "anello", title: "anello", categoryId: SHOPPING),
  "apm monaco":
      Shop(lowercase: "apm monaco", title: 'APM Monaco', categoryId: SHOPPING),
  "apple": Shop(lowercase: "apple", title: "Apple", categoryId: SHOPPING),
  "aptimos": Shop(lowercase: "aptimos", title: "aptimos", categoryId: SHOPPING),
  "aroma truffle": Shop(
      lowercase: "aroma truffle",
      title: " Aroma truffle",
      categoryId: FOODDRINKS),
  "asian artistry": Shop(
      lowercase: "asian artistry",
      title: " Asian Artistry",
      categoryId: SHOPPING),
  "bakery cuisine premium": Shop(
      lowercase: "bakery cuisine premium",
      title: "Bakery Cuisine Premium",
      categoryId: FOODDRINKS),
  "bata": Shop(lowercase: "bata", title: "Bata", categoryId: SHOPPING),
  "bee cheng hiang": Shop(
      lowercase: "bee cheng hiang",
      title: "BEE CHENG HIANG",
      categoryId: FOODDRINKS),
  "bengawan solo": Shop(
      lowercase: "bengawan solo",
      title: "Bengawan Solo",
      categoryId: FOODDRINKS),
  "bloomb": Shop(lowercase: "bloomb", title: "bloomB", categoryId: SHOPPING),
  "boarding gate": Shop(
      lowercase: "boarding gate", title: "Boarding Gate", categoryId: SHOPPING),
  "bossini": Shop(lowercase: "bossini", title: "Bossini", categoryId: SHOPPING),
  "bottles & bottles": Shop(
      lowercase: "bottles & bottles",
      title: "Bottles & Bottles",
      categoryId: SHOPPING),
  "breadtalk":
      Shop(lowercase: "breadtalk", title: "BreadTalk", categoryId: FOODDRINKS),
  "bysi": Shop(lowercase: "bysi", title: "bYSI", categoryId: SHOPPING),
  "calvin klein": Shop(
      lowercase: "calvin klein", title: "Calvin Klein", categoryId: SHOPPING),
  "candy empire": Shop(
      lowercase: "candy empire", title: "Candy Empire", categoryId: FOODDRINKS),
  "carter's":
      Shop(lowercase: "carter's", title: "carter's", categoryId: SHOPPING),
  "challenger": Shop(
      lowercase: "challenger", title: "Challenger", categoryId: ELECTRONICS),
  "charles & keith": Shop(
      lowercase: "charles & keith",
      title: "Charles & Keith",
      categoryId: SHOPPING),
  "cheers": Shop(lowercase: "cheers", title: 'Cheers', categoryId: FOODDRINKS),
  "chocolate origin": Shop(
      lowercase: "chocolate origin",
      title: "Chocolate Origin",
      categoryId: FOODDRINKS),
  "chomel": Shop(lowercase: "chomel", title: "Chomel", categoryId: SHOPPING),
  "coach": Shop(lowercase: "coach", title: "Coach", categoryId: SHOPPING),
  "cold storage": Shop(
      lowercase: "cold storage", title: 'Cold Storage', categoryId: FOODDRINKS),
  "daniel wellington": Shop(
      lowercase: "daniel wellington",
      title: "Daniel Wellington",
      categoryId: SHOPPING),
  "durian mpire": Shop(
      lowercase: "durian mpire", title: "Durian Mpire", categoryId: FOODDRINKS),
  "eu yan sang":
      Shop(lowercase: "eu yan sang", title: "Eu Yan Sang", categoryId: HEALTH),
  "fairprice":
      Shop(lowercase: "fairprice", title: 'Fairprice', categoryId: FOODDRINKS),
  "fairprice finest": Shop(
      lowercase: "fairprice finest",
      title: 'Fairprice Finest',
      categoryId: FOODDRINKS),
  "fila": Shop(lowercase: "fila", title: "FILA", categoryId: SHOPPING),
  "foot locker": Shop(
      lowercase: "foot locker", title: "Foot Locker", categoryId: SHOPPING),
  "four seasons restaurant": Shop(
      lowercase: "four seasons restaurant",
      title: "Four Seasons Restaurant",
      categoryId: FOODDRINKS),
  "fred perry":
      Shop(lowercase: "fred perry", title: "Fred Perry", categoryId: SHOPPING),
  "golden village": Shop(
      lowercase: "golden village",
      title: 'Golden Village',
      categoryId: ENTERTAINMENT),
  "hachi tech": Shop(
      lowercase: "hachi tech", title: 'Hachi Tech', categoryId: ELECTRONICS),
  "kfc": Shop(lowercase: "kfc", title: 'KFC', categoryId: FOODDRINKS),
  "koi": Shop(lowercase: "koi", title: 'Koi', categoryId: FOODDRINKS),
  "mcdonald's": Shop(
      lowercase: "mcdonald's", title: "McDonald's", categoryId: FOODDRINKS),
  "paylah": Shop(lowercase: "paylah", title: 'Paylah', categoryId: OTHERS),
  "paynow": Shop(lowercase: "paynow", title: 'Paynow', categoryId: OTHERS),
  "pepper lunch": Shop(
      lowercase: "pepper lunch", title: 'Pepper Lunch', categoryId: FOODDRINKS),
  "popular":
      Shop(lowercase: "popular", title: 'Popular', categoryId: EDUCATION),
  "ride":
      Shop(lowercase: "ride", title: 'Grab ride', categoryId: TRANSPORTATION),
  "starbucks":
      Shop(lowercase: "starbucks", title: 'Starbucks', categoryId: FOODDRINKS),
  "uniqlo": Shop(lowercase: "uniqlo", title: 'UNIQLO', categoryId: SHOPPING),
  "monster curry": Shop(
      lowercase: "monster curry",
      title: 'Monster Curry',
      categoryId: FOODDRINKS),
};
