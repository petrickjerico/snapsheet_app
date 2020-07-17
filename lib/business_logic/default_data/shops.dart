import 'package:snapsheetapp/business_logic/models/models.dart';

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
  "a&w": Shop(lowercase: "a&w", title: "A&W", categoryId: FOODDRINKS),
  "aone":
      Shop(lowercase: "aone", title: "A-One Signature", categoryId: FOODDRINKS),
  "ac kafe":
      Shop(lowercase: 'ac kafe', title: 'AC.Kafe', categoryId: FOODDRINKS),
  "ace": Shop(lowercase: "ace", title: "ace.", categoryId: SHOPPING),
  "action city": Shop(
      lowercase: "action city", title: "Action City", categoryId: SHOPPING),
  "aloha poke": Shop(
      lowercase: "aloha poke", title: "aloha poke", categoryId: FOODDRINKS),
  "adidas": Shop(lowercase: "adidas", title: 'Adidas', categoryId: SHOPPING),
  "american tourister": Shop(
      lowercase: "american tourister",
      title: "American Tourister",
      categoryId: SHOPPING),
  "an acai affair": Shop(
      lowercase: "an acai affair",
      title: " An Acai Affair",
      categoryId: FOODDRINKS),
  "andersen's": Shop(
      lowercase: "andersen's", title: "Andersen's", categoryId: FOODDRINKS),
  "anello": Shop(lowercase: "anello", title: "anello", categoryId: SHOPPING),
  "apm monaco":
      Shop(lowercase: "apm monaco", title: 'APM Monaco', categoryId: SHOPPING),
  "apple": Shop(lowercase: "apple", title: "Apple", categoryId: SHOPPING),
  "aptimos": Shop(lowercase: "aptimos", title: "aptimos", categoryId: SHOPPING),
  "aroma truffle": Shop(
      lowercase: "aroma truffle",
      title: " Aroma truffle",
      categoryId: FOODDRINKS),
  "arteastiq":
      Shop(lowercase: "arteastiq", title: "arteastiq", categoryId: FOODDRINKS),
  "asian artistry": Shop(
      lowercase: "asian artistry",
      title: " Asian Artistry",
      categoryId: SHOPPING),
  "auntie anne's": Shop(
      lowercase: "auntie anne's",
      title: " Auntie Anne's",
      categoryId: FOODDRINKS),
  "bakery cuisine premium": Shop(
      lowercase: "bakery cuisine premium",
      title: "Bakery Cuisine Premium",
      categoryId: FOODDRINKS),
  "bata": Shop(lowercase: "bata", title: "Bata", categoryId: SHOPPING),
  "beauty in the pot": Shop(
      lowercase: "beauty in the pot",
      title: "Beauty in the Pot",
      categoryId: FOODDRINKS),
  "bee cheng hiang": Shop(
      lowercase: "bee cheng hiang",
      title: "BEE CHENG HIANG",
      categoryId: FOODDRINKS),
  "bengawan solo": Shop(
      lowercase: "bengawan solo",
      title: "Bengawan Solo",
      categoryId: FOODDRINKS),
  "big bird":
      Shop(lowercase: "big bird", title: "Big Bird", categoryId: FOODDRINKS),
  "birds of paradise": Shop(
      lowercase: "birds of paradise",
      title: "Birds of Paradise",
      categoryId: FOODDRINKS),
  "bloomb": Shop(lowercase: "bloomb", title: "bloomB", categoryId: SHOPPING),
  "boarding gate": Shop(
      lowercase: "boarding gate", title: "Boarding Gate", categoryId: SHOPPING),
  "boost": Shop(lowercase: "boost", title: "Boos", categoryId: FOODDRINKS),
  "bossini": Shop(lowercase: "bossini", title: "Bossini", categoryId: SHOPPING),
  "bottles & bottles": Shop(
      lowercase: "bottles & bottles",
      title: "Bottles & Bottles",
      categoryId: SHOPPING),
  "breadtalk":
      Shop(lowercase: "breadtalk", title: "BreadTalk", categoryId: FOODDRINKS),
  "burger & lobster": Shop(
      lowercase: "burger & lobster",
      title: "Burger & Lobster",
      categoryId: FOODDRINKS),
  "burger king": Shop(
      lowercase: " burger king", title: "Burger King", categoryId: FOODDRINKS),
  "bysi": Shop(lowercase: "bysi", title: "bYSI", categoryId: SHOPPING),
  "cafe amazon": Shop(
      lowercase: "cafe amazon", title: "Cafe Amazon", categoryId: FOODDRINKS),
  "cafe morozoff": Shop(
      lowercase: "cafe morozoff",
      title: "Cafe Morozoff",
      categoryId: FOODDRINKS),
  "calvin klein": Shop(
      lowercase: "calvin klein", title: "Calvin Klein", categoryId: SHOPPING),
  "candy empire": Shop(
      lowercase: "candy empire", title: "Candy Empire", categoryId: FOODDRINKS),
  "carter's":
      Shop(lowercase: "carter's", title: "carter's", categoryId: SHOPPING),
  "cath kidston": Shop(
      lowercase: "cath kidston", title: "Cath Kidston", categoryId: SHOPPING),
  "cedele": Shop(lowercase: "cedele", title: "Cedele", categoryId: FOODDRINKS),
  "challenger": Shop(
      lowercase: "challenger", title: "Challenger", categoryId: ELECTRONICS),
  "chalone": Shop(lowercase: "chalone", title: "Chalone", categoryId: SHOPPING),
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
  "chow tai fook": Shop(
      lowercase: "chow tai fook", title: "CHOW TAI FOOK", categoryId: SHOPPING),
  "chun yang tea": Shop(
      lowercase: "chun yang tea", title: "Chun Yang Tea", categoryId: SHOPPING),
  "clarks": Shop(lowercase: "clarks", title: "Clarks", categoryId: SHOPPING),
  "coach": Shop(lowercase: "coach", title: "Coach", categoryId: SHOPPING),
  "coffee@works": Shop(
      lowercase: "coffee@works", title: "Coffee@Works", categoryId: FOODDRINKS),
  "cold storage": Shop(
      lowercase: "cold storage", title: 'Cold Storage', categoryId: FOODDRINKS),
  "commons":
      Shop(lowercase: "commons", title: "Commons", categoryId: FOODDRINKS),
  "cotton on kids": Shop(
      lowercase: "cotton on kids",
      title: "Cotton On Kids",
      categoryId: SHOPPING),
  "crocs": Shop(lowercase: "crocs", title: "crocs", categoryId: SHOPPING),
  "cuttour hair studio": Shop(
      lowercase: "cuttour hair studio",
      title: "Cuttour Hair Studio",
      categoryId: HEALTH),
  "d'good cafe": Shop(
      lowercase: "d'good cafe", title: "D'Good Cafe", categoryId: FOODDRINKS),
  "dal.komm": Shop(
      lowercase: "dal.komm", title: "dal.komm coffee", categoryId: FOODDRINKS),
  "daniel wellington": Shop(
      lowercase: "daniel wellington",
      title: "Daniel Wellington",
      categoryId: SHOPPING),
  "denizen": Shop(lowercase: "denizen", title: "denizen", categoryId: SHOPPING),
  "dermalogica":
      Shop(lowercase: "dermalogica", title: "dermalogica", categoryId: HEALTH),
  "desigual":
      Shop(lowercase: "desigual", title: "desigual.", categoryId: SHOPPING),
  "diamanti per tutti": Shop(
      lowercase: "diamanti per tutti",
      title: "Diamanti Per Tutti",
      categoryId: SHOPPING),
  "dian xiao er": Shop(
      lowercase: "dian xiao er", title: "Dian Xiao Er", categoryId: FOODDRINKS),
  "did": Shop(lowercase: "did", title: "D!D", categoryId: GIVING),
  "din tai fung": Shop(
      lowercase: "din tai fung", title: "Din Tai Fung", categoryId: FOODDRINKS),
  "ducks & crafts": Shop(
      lowercase: "ducks & crafts", title: "Ducks & Crafts", categoryId: GIVING),
  "dunkin' donuts": Shop(
      lowercase: "dunkin' donuts",
      title: "Dunkin' Donuts",
      categoryId: FOODDRINKS),
  "durasport":
      Shop(lowercase: "durasport", title: "Durasport", categoryId: SHOPPING),
  "durian mpire": Shop(
      lowercase: "durian mpire", title: "Durian Mpire", categoryId: FOODDRINKS),
  "earle swensen's": Shop(
      lowercase: "earle swensen's",
      title: "Earle Swensen's",
      categoryId: FOODDRINKS),
  "ecco": Shop(lowercase: "ecco", title: "ecco", categoryId: SHOPPING),
  "eggs 'n things": Shop(
      lowercase: "eggs 'n things",
      title: "Eggs 'n Things",
      categoryId: FOODDRINKS),
  "el fluego": Shop(
      lowercase: "el fluego",
      title: "Elfluego by COLLIN'S",
      categoryId: FOODDRINKS),
  "emack & bolio's": Shop(
      lowercase: "Emack & Bolio's",
      title: "emack & bolio's",
      categoryId: FOODDRINKS),
  "eu yan sang":
      Shop(lowercase: "eu yan sang", title: "Eu Yan Sang", categoryId: HEALTH),
  "evisu": Shop(lowercase: "evisu", title: "evisu", categoryId: SHOPPING),
  "expressions":
      Shop(lowercase: "expressions", title: "Expressions", categoryId: HEALTH),
  "fairprice":
      Shop(lowercase: "fairprice", title: 'Fairprice', categoryId: FOODDRINKS),
  "fairprice finest": Shop(
      lowercase: "fairprice finest",
      title: 'Fairprice Finest',
      categoryId: FOODDRINKS),
  "fila": Shop(lowercase: "fila", title: "FILA", categoryId: SHOPPING),
  "fila kids":
      Shop(lowercase: "fila kids", title: "FILA KIDS", categoryId: SHOPPING),
  "five spice": Shop(
      lowercase: "five spice", title: "FIVE SPICE", categoryId: FOODDRINKS),
  "foot locker": Shop(
      lowercase: "foot locker", title: "Foot Locker", categoryId: SHOPPING),
  "fotohub": Shop(lowercase: "fotohub", title: "FotoHub", categoryId: GIVING),
  "four seasons restaurant": Shop(
      lowercase: "four seasons restaurant",
      title: "Four Seasons Restaurant",
      categoryId: FOODDRINKS),
  "fred perry":
      Shop(lowercase: "fred perry", title: "Fred Perry", categoryId: SHOPPING),
  "franck muller": Shop(
      lowercase: "franck muller", title: "FRANCK MULLER", categoryId: SHOPPING),
  "fun toast":
      Shop(lowercase: "fun toast", title: "Fun Toast", categoryId: FOODDRINKS),
  "furla": Shop(lowercase: "furla", title: "Furla", categoryId: SHOPPING),
  "g-star raw":
      Shop(lowercase: "g-star raw", title: "G-Star Raw", categoryId: SHOPPING),
  "g2000": Shop(lowercase: "g2000", title: "G2000", categoryId: SHOPPING),
  "gg<5": Shop(lowercase: "gg<5", title: "GG<5", categoryId: SHOPPING),
  "gift": Shop(lowercase: "gift", title: "GIFT", categoryId: GIVING),
  "giordano":
      Shop(lowercase: "giordano", title: "Giordano", categoryId: SHOPPING),
  "giordano ladies": Shop(
      lowercase: "giordano ladies",
      title: "Giordano Ladies",
      categoryId: SHOPPING),
  "gnc": Shop(lowercase: "gnc", title: "GNC", categoryId: HEALTH),
  "gochi-so shokudo": Shop(
      lowercase: "gochi-so shokudo",
      title: "Gochi-So Shokudo",
      categoryId: FOODDRINKS),
  "golden village": Shop(
      lowercase: "golden village",
      title: 'Golden Village',
      categoryId: ENTERTAINMENT),
  "hachi tech": Shop(
      lowercase: "hachi tech", title: 'Hachi Tech', categoryId: ELECTRONICS),
  "heritage":
      Shop(lowercase: "heritage", title: "HERITAGE", categoryId: FOODDRINKS),
  "hoshino coffee": Shop(
      lowercase: "hoshino coffee",
      title: "Hoshino Coffee",
      categoryId: FOODDRINKS),
  "hot tomato": Shop(
      lowercase: "hot tomato", title: "Hot Tomato", categoryId: FOODDRINKS),
  "hsbc": Shop(lowercase: "hsbc", title: "HSBC", categoryId: OTHERS),
  "honeyworld": Shop(
      lowercase: "honeyworld", title: "HoneyWorld", categoryId: FOODDRINKS),
  "hugo": Shop(lowercase: "hugo", title: "HUGO", categoryId: SHOPPING),
  "in good company": Shop(
      lowercase: "in good company",
      title: "IN GOOD COMPANY",
      categoryId: SHOPPING),
  "iroo": Shop(lowercase: "iroo", title: "iROO", categoryId: SHOPPING),
  "irvins salted egg": Shop(
      lowercase: "irvins salted egg",
      title: "Irvins Salted Egg",
      categoryId: SHOPPING),
  "itacho sushi": Shop(
      lowercase: "Itacho Sushi", title: "itacho sushi", categoryId: FOODDRINKS),
  "jw360": Shop(lowercase: "jw360", title: "JW360", categoryId: FOODDRINKS),
  "jw360 cafe": Shop(
      lowercase: "jw360 cafe", title: "JW360 CAFE", categoryId: FOODDRINKS),
  "jw360 nomono": Shop(
      lowercase: "jw360 nomono", title: "JW360 nomono", categoryId: FOODDRINKS),
  "jw360 suju masayuki": Shop(
      lowercase: "jw360 suju masayuki",
      title: "JW360 SUJU MASAYUKI JAPANESE RESTAURANT",
      categoryId: FOODDRINKS),
  "jacadi paris": Shop(
      lowercase: "jacadi paris", title: "Jacadi Paris", categoryId: SHOPPING),
  "jack's place": Shop(
      lowercase: "jack's place", title: "Jack's Place", categoryId: FOODDRINKS),
  "japanese soba noodles tsuta": Shop(
      lowercase: "japanese soba noodles tsuta",
      title: "Japanese Soba Noodles Tsuta",
      categoryId: FOODDRINKS),
  "jinjja chicken": Shop(
      lowercase: "jinjja chicken",
      title: "JINJJA CHICKEN",
      categoryId: FOODDRINKS),
  "juewei": Shop(lowercase: "juewei", title: "JUEWEI", categoryId: FOODDRINKS),
  "jumbo seafood": Shop(
      lowercase: "jumbo seafood",
      title: "JUMBO SEAFOOD",
      categoryId: FOODDRINKS),
  "k. minamoto": Shop(
      lowercase: "k. minamoto", title: "K. Minamoto", categoryId: FOODDRINKS),
  "kane mochi": Shop(
      lowercase: "kane mochi", title: "KANE MOCHI", categoryId: FOODDRINKS),
  "kappa": Shop(lowercase: "kappa", title: "Kappa", categoryId: SHOPPING),
  "kate spade":
      Shop(lowercase: "kate spade", title: "kate spade", categoryId: SHOPPING),
  "kfc": Shop(lowercase: "kfc", title: 'KFC', categoryId: FOODDRINKS),
  "kiehl's": Shop(lowercase: "kiehl's", title: "Kiehl's", categoryId: HEALTH),
  "kimoj": Shop(lowercase: "kimoj", title: "Kimoj", categoryId: SHOPPING),
  "kipling": Shop(lowercase: "kipling", title: "kipling", categoryId: SHOPPING),
  "kko kko nara": Shop(
      lowercase: "kko kko nara", title: "Kko Kko Nara", categoryId: FOODDRINKS),
  "klosh": Shop(lowercase: "klosh", title: "Klosh", categoryId: GIVING),
  "koi": Shop(lowercase: "koi", title: 'Koi', categoryId: FOODDRINKS),
  "l'eclair patisserie": Shop(
      lowercase: "l'eclair patisserie",
      title: "L'eclair Patisserie",
      categoryId: FOODDRINKS),
  "lacoste": Shop(lowercase: "lacoste", title: "Lacoste", categoryId: SHOPPING),
  "lady m": Shop(lowercase: "lady m", title: "Lady M", categoryId: FOODDRINKS),
  "la lola churreria": Shop(
      lowercase: "la lola churreria",
      title: "La Lola Churreria",
      categoryId: FOODDRINKS),
  "lavender":
      Shop(lowercase: "lavender", title: "Lavender", categoryId: FOODDRINKS),
  "lenu": Shop(lowercase: "lenu", title: "LeNu", categoryId: FOODDRINKS),
  "levi's": Shop(lowercase: "levi's", title: "Levi's", categoryId: SHOPPING),
  "lim chee guan": Shop(
      lowercase: "lim chee guan",
      title: "Lim Chee Guan",
      categoryId: FOODDRINKS),
  "little red dot": Shop(
      lowercase: "little red dot", title: "Little Red Dot", categoryId: GIVING),
  "love & co":
      Shop(lowercase: "love & co", title: "Love & Co", categoryId: SHOPPING),
  "love moschino": Shop(
      lowercase: "love moschino", title: "Love Moschino", categoryId: SHOPPING),
  "laderach chocolatier suisse": Shop(
      lowercase: "laderach chocolatier suisse",
      title: "Laderach Chocolatier Suisse",
      categoryId: FOODDRINKS),
  "maison de pb": Shop(
      lowercase: "maison de pb", title: "Maison de PB", categoryId: FOODDRINKS),
  "mango": Shop(lowercase: "mango", title: "MANGO", categoryId: SHOPPING),
  "mark nason":
      Shop(lowercase: "mark nason", title: "Mark Nason", categoryId: SHOPPING),
  "marks & spencer": Shop(
      lowercase: "marks & skechers",
      title: "Marks & Spencers",
      categoryId: SHOPPING),
  "massimo dutti": Shop(
      lowercase: "massimo dutti", title: "Massimo Dutti", categoryId: SHOPPING),
  "mcdonald's": Shop(
      lowercase: "mcdonald's", title: "McDonald's", categoryId: FOODDRINKS),
  "mellower coffee": Shop(
      lowercase: "mellower coffee",
      title: "Mellower Coffee",
      categoryId: FOODDRINKS),
  "meyson": Shop(lowercase: "meyson", title: "Meyson", categoryId: SHOPPING),
  "miss hosay":
      Shop(lowercase: "miss hosay", title: "Miss HoSay", categoryId: GIVING),
  "monster curry": Shop(
      lowercase: "monster curry",
      title: 'Monster Curry',
      categoryId: FOODDRINKS),
  "mos cafe":
      Shop(lowercase: "mos cafe", title: "MOS Cafe", categoryId: FOODDRINKS),
  "mothercare":
      Shop(lowercase: "mothercare", title: "Mothercare", categoryId: SHOPPING),
  "motherhouse": Shop(
      lowercase: "motherhouse", title: "MOTHERHOUSE", categoryId: SHOPPING),
  "mr bean":
      Shop(lowercase: "mr bean", title: "Mr Bean", categoryId: FOODDRINKS),
  "mr coconut": Shop(
      lowercase: "mr coconut", title: "Mr. Coconut", categoryId: FOODDRINKS),
  "Muji": Shop(lowercase: "muji", title: "MUJI", categoryId: SHOPPING),
  "myeureka":
      Shop(lowercase: "myeureka", title: "myEureka", categoryId: FOODDRINKS),
  "naiise": Shop(lowercase: "naiise", title: "Naiise.", categoryId: SHOPPING),
  "naiise iconic": Shop(
      lowercase: "naiise iconic",
      title: "Naiise Iconic",
      categoryId: FOODDRINKS),
  "nam kee pau": Shop(
      lowercase: "nam kee pau",
      title: "Nam Kee Pau / Hong Kong Egglet",
      categoryId: FOODDRINKS),
  "nectar": Shop(lowercase: "nectar", title: "Nectar", categoryId: FOODDRINKS),
  "new balance": Shop(
      lowercase: "new balance", title: "New Balance", categoryId: SHOPPING),
  "nike": Shop(lowercase: "nike", title: "Nike", categoryId: SHOPPING),
  "nine fresh": Shop(
      lowercase: "nine fresh", title: "Nine Fresh", categoryId: FOODDRINKS),
  "ning foot & back spa": Shop(
      lowercase: "ning foot & back spa",
      title: "Ning Foot & Back Spa",
      categoryId: HEALTH),
  "o'coffee club": Shop(
      lowercase: "o'coffee club",
      title: "O'Coffee Club",
      categoryId: FOODDRINKS),
  "o'tah": Shop(lowercase: "o'tah", title: "O'TAH", categoryId: FOODDRINKS),
  "obermain":
      Shop(lowercase: "obermain", title: "Obermain", categoryId: SHOPPING),
  "ogawa": Shop(lowercase: "ogawa", title: "Ogawa", categoryId: HEALTH),
  "ole ole":
      Shop(lowercase: "ole ole", title: "ole ole", categoryId: FOODDRINKS),
  "old chang kee": Shop(
      lowercase: "old chang kee",
      title: "Old Chang Kee",
      categoryId: FOODDRINKS),
  "onitsuka tiger": Shop(
      lowercase: "onitsuka tiger",
      title: "Onitsuka Tiger",
      categoryId: SHOPPING),
  "orient crown": Shop(
      lowercase: "orient crown", title: "ORIENT CROWN", categoryId: SHOPPING),
  "osim": Shop(lowercase: "osim", title: "OSIM", categoryId: HEALTH),
  "owell": Shop(lowercase: "osim", title: "OWELL", categoryId: HEALTH),
  "owndays": Shop(lowercase: "owndays", title: "OWNDAYS", categoryId: HEALTH),
  "oysho": Shop(lowercase: "oysho", title: "OYSHO", categoryId: SHOPPING),
  "pandora": Shop(lowercase: "pandora", title: "PANDORA", categoryId: SHOPPING),
  "paradise classic": Shop(
      lowercase: "paradise classic",
      title: "Paradise Classic",
      categoryId: FOODDRINKS),
  "paris baguette signature": Shop(
      lowercase: "paris baguette signature",
      title: "Paris Baguette Signature",
      categoryId: FOODDRINKS),
  "paris miki":
      Shop(lowercase: "paris miki", title: "Paris Miki", categoryId: HEALTH),
  "pazzion": Shop(lowercase: "pazzion", title: "PAZZION", categoryId: SHOPPING),
  "pazzion cafe": Shop(
      lowercase: "pazzion cafe", title: "Pazzion Cafe", categoryId: FOODDRINKS),
  "paylah": Shop(lowercase: "paylah", title: 'Paylah', categoryId: OTHERS),
  "paynow": Shop(lowercase: "paynow", title: 'Paynow', categoryId: OTHERS),
  "pedro": Shop(lowercase: "pedro", title: "Pedro", categoryId: SHOPPING),
  "pepper lunch": Shop(
      lowercase: "pepper lunch", title: 'Pepper Lunch', categoryId: FOODDRINKS),
  "perch": Shop(lowercase: "perch", title: "Perch", categoryId: FOODDRINKS),
  "pet lovers center": Shop(
      lowercase: "pet lovers centre",
      title: "Pet Lovers Centre",
      categoryId: OTHERS),
  "petit bateau": Shop(
      lowercase: "petit bateau", title: "Petit Bateau", categoryId: SHOPPING),
  "picota": Shop(lowercase: "picota", title: "Picota", categoryId: HEALTH),
  "pink fish":
      Shop(lowercase: "pink fish", title: "Pink Fish", categoryId: FOODDRINKS),
  "pizzaexpress": Shop(
      lowercase: "pizzaexpress", title: "PizzaExpress", categoryId: FOODDRINKS),
  "pizzamaru":
      Shop(lowercase: "pizzamaru", title: "PizzaMaru", categoryId: FOODDRINKS),
  "pokemon": Shop(lowercase: "pokemon", title: "Pokemon", categoryId: SHOPPING),
  "popular":
      Shop(lowercase: "popular", title: 'Popular', categoryId: EDUCATION),
  "potato corner": Shop(
      lowercase: "potato corner",
      title: "Potato Corner",
      categoryId: FOODDRINKS),
  "pow sing":
      Shop(lowercase: "pow sing", title: "Pow Sing", categoryId: FOODDRINKS),
  "prive": Shop(lowercase: "prive", title: "Prive", categoryId: FOODDRINKS),
  "puma": Shop(lowercase: "puma", title: "PUMA", categoryId: SHOPPING),
  "putien": Shop(lowercase: "putien", title: "PUTIEN", categoryId: FOODDRINKS),
  "qb house":
      Shop(lowercase: "qb house", title: "QB House", categoryId: HEALTH),
  "rabeanco":
      Shop(lowercase: "rabeanco", title: "Rabeanco", categoryId: SHOPPING),
  "red lips":
      Shop(lowercase: "red lips", title: "Red Lips", categoryId: FOODDRINKS),
  "rich & good": Shop(
      lowercase: "rich & good", title: "Rich & Good", categoryId: FOODDRINKS),
  "ride":
      Shop(lowercase: "ride", title: 'Grab ride', categoryId: TRANSPORTATION),
  "rip curl":
      Shop(lowercase: "rip curl", title: "Rip Curl", categoryId: SHOPPING),
  "risis tresor": Shop(
      lowercase: "risis tresor", title: "Risis Tresor", categoryId: SHOPPING),
  "rookie": Shop(lowercase: "rookie", title: "Rookie", categoryId: SHOPPING),
  "rubi": Shop(lowercase: "rubi", title: "rubi", categoryId: SHOPPING),
  "rumours bar": Shop(
      lowercase: "rumours bar", title: "Rumours Bar", categoryId: FOODDRINKS),
  "samjin amook": Shop(
      lowercase: "samjin amook", title: "samjin Amook", categoryId: FOODDRINKS),
  "samsonite":
      Shop(lowercase: "samsonite", title: "Samsonite", categoryId: SHOPPING),
  "saap saap thai": Shop(
      lowercase: "saap saap thai",
      title: "Saap Saap Thai",
      categoryId: FOODDRINKS),
  "sama sama": Shop(
      lowercase: "sama sama",
      title: "Sama Sama by Tok Tok",
      categoryId: FOODDRINKS),
  "sankranti":
      Shop(lowercase: "sankranti", title: "Sankranti", categoryId: FOODDRINKS),
  "shake shack": Shop(
      lowercase: "shake shack", title: "Shake Shack", categoryId: FOODDRINKS),
  "shang social": Shop(
      lowercase: "shang social", title: "Shang Social", categoryId: FOODDRINKS),
  "shaw theatres": Shop(
      lowercase: "shaw theatres",
      title: "Shaw Theatres",
      categoryId: ENTERTAINMENT),
  "shiki hototogitsu ramen": Shop(
      lowercase: "shiki hototogitsu ramen",
      title: "Shiki Hototogitsu Ramen",
      categoryId: FOODDRINKS),
  "signature koi": Shop(
      lowercase: "signature koi",
      title: "Signature KOI",
      categoryId: FOODDRINKS),
  "sincere": Shop(lowercase: "sincere", title: "Sincere", categoryId: SHOPPING),
  "sk jewellery": Shop(
      lowercase: "sk jewellery", title: "SK Jewellery", categoryId: SHOPPING),
  "skechers":
      Shop(lowercase: "skechers", title: "Skechers", categoryId: SHOPPING),
  "skeda": Shop(lowercase: "skeda", title: "Skeda", categoryId: SHOPPING),
  "so pho": Shop(lowercase: "so pho", title: "So Pho", categoryId: FOODDRINKS),
  "sole spirit": Shop(
      lowercase: "sole spirit", title: "Sole Spirit", categoryId: SHOPPING),
  "song fa": Shop(
      lowercase: "song fa",
      title: "Song Fa Bak Kut Teh",
      categoryId: FOODDRINKS),
  "soup restaurant": Shop(
      lowercase: "soup restaurant",
      title: "Soup Restaurant",
      categoryId: FOODDRINKS),
  "spectacle hut": Shop(
      lowercase: "spectacle hut", title: "Spectacle Hut", categoryId: HEALTH),
  "starbucks":
      Shop(lowercase: "starbucks", title: 'Starbucks', categoryId: FOODDRINKS),
  "stuff'd":
      Shop(lowercase: "stuff'd", title: "STUFF'D", categoryId: FOODDRINKS),
  "suage hokkaido": Shop(
      lowercase: "suage hokkaido",
      title: "Suage Hokkaido Soup Curry",
      categoryId: FOODDRINKS),
  "subway": Shop(lowercase: "subway", title: "SUBWAY", categoryId: FOODDRINKS),
  "sultans of shave": Shop(
      lowercase: "sultans of shave",
      title: "Sultans of Shave",
      categoryId: HEALTH),
  "supermama":
      Shop(lowercase: "supermama", title: "Supermama", categoryId: GIVING),
  "sushi tei":
      Shop(lowercase: "sushi tei", title: "Sushi Tei", categoryId: FOODDRINKS),
  "swatow kitchen": Shop(
      lowercase: "swatow kitchen",
      title: "Swatow Kitchen",
      categoryId: FOODDRINKS),
  "tanuki raw": Shop(
      lowercase: "tanuki raw", title: "Tanuki Raw", categoryId: FOODDRINKS),
  "tapas club": Shop(
      lowercase: "tapas club", title: "Tapas Club", categoryId: FOODDRINKS),
  "taste singapore": Shop(
      lowercase: "taste singapore",
      title: "Taste Singapore",
      categoryId: FOODDRINKS),
  "thaiexpress": Shop(
      lowercase: "thaiexpress",
      title: "ThaiExpress Signature",
      categoryId: FOODDRINKS),
  "the alley":
      Shop(lowercase: "the alley", title: "The Alley", categoryId: FOODDRINKS),
  "the better toy store": Shop(
      lowercase: "the better toy store",
      title: "The Better Toy Store",
      categoryId: SHOPPING),
  "the body shop": Shop(
      lowercase: "the body shop", title: "The Body Shop", categoryId: HEALTH),
  "the green party": Shop(
      lowercase: "the green party",
      title: "The Green Party",
      categoryId: SHOPPING),
  "the shirt bar": Shop(
      lowercase: "the shirt bar", title: "The Shirt Bar", categoryId: SHOPPING),
  "the smell lab": Shop(
      lowercase: "the smell lab", title: "The Smell Lab", categoryId: HEALTH),
  "thye moh chan": Shop(
      lowercase: "thye moh chan",
      title: "Thye Moh Chan",
      categoryId: FOODDRINKS),
  "tiger street lab": Shop(
      lowercase: "tiger street lab",
      title: "Tiger Street Lab",
      categoryId: FOODDRINKS),
  "tim ho wan": Shop(
      lowercase: "tim ho wan", title: "Tim Ho Wan", categoryId: FOODDRINKS),
  "timberland":
      Shop(lowercase: "timberland", title: "Timberland", categoryId: SHOPPING),
  "timeless":
      Shop(lowercase: "timeless", title: "Timeless", categoryId: SHOPPING),
  "times junior": Shop(
      lowercase: "times junior", title: "Times Junior", categoryId: GIVING),
  "toast box":
      Shop(lowercase: "toast box", title: "Toast Box", categoryId: FOODDRINKS),
  "tokyo milk cheese": Shop(
      lowercase: "tokyo milk cheese",
      title: "Tokyo Milk Cheese & Cow Cow Kitchen",
      categoryId: FOODDRINKS),
  "tokyu hands": Shop(
      lowercase: "tokyu hands", title: "TOKYU HANDS", categoryId: SHOPPING),
  "tong garden": Shop(
      lowercase: "tong garden", title: "Tong Garden", categoryId: FOODDRINKS),
  "tonito": Shop(lowercase: "tonito", title: "TONITO", categoryId: FOODDRINKS),
  "tonkatsu by ma maison": Shop(
      lowercase: "tonkatsu by ma maison",
      title: "Tonkatsu By Ma Maison",
      categoryId: FOODDRINKS),
  "triumph": Shop(lowercase: "triumph", title: "Triumph", categoryId: SHOPPING),
  "turtle": Shop(lowercase: "turtle", title: "TURTLE", categoryId: SHOPPING),
  "twelve cupcakes": Shop(
      lowercase: "twelve cupcakes",
      title: "Twelve Cupcakes",
      categoryId: FOODDRINKS),
  "typo": Shop(lowercase: "typo", title: "Typo", categoryId: SHOPPING),
  "unicalf": Shop(lowercase: "unicalf", title: "UniCalf", categoryId: SHOPPING),
  "uniqlo": Shop(lowercase: "uniqlo", title: 'UNIQLO', categoryId: SHOPPING),
  "urban revivo": Shop(
      lowercase: "urban revivo", title: "Urban Revivo", categoryId: SHOPPING),
  "vans": Shop(lowercase: "vans", title: "VANS", categoryId: SHOPPING),
  "victoria's secret": Shop(
      lowercase: "victoria's secret",
      title: "Victoria's Secret",
      categoryId: SHOPPING),
  "violet oon": Shop(
      lowercase: "violet oon",
      title: "Violet Oon Singapore",
      categoryId: FOODDRINKS),
  "vision lab":
      Shop(lowercase: "vision lab", title: "Vision Lab", categoryId: HEALTH),
  "w optics":
      Shop(lowercase: "w optics", title: "W Optics", categoryId: HEALTH),
  "watsons": Shop(lowercase: "watsons", title: "Watsons", categoryId: HEALTH),
  "white restaurant": Shop(
      lowercase: "white restaurant",
      title: "White Restaurant",
      categoryId: FOODDRINKS),
  "xi": Shop(lowercase: "xi", title: "Xi", categoryId: SHOPPING),
  "xpressflower. Com": Shop(
      lowercase: "xpressflower. com",
      title: "Xpressflower.com",
      categoryId: GIVING),
  "yacht 21":
      Shop(lowercase: "yacht 21", title: "Yacht 21", categoryId: SHOPPING),
  "yun nans":
      Shop(lowercase: "yun nans", title: "Yun Nans", categoryId: FOODDRINKS),
  "zara": Shop(lowercase: "zara", title: "ZARA", categoryId: SHOPPING),
};
