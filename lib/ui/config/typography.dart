import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle kWelcomeTextStyle = GoogleFonts.lato(
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
  letterSpacing: 4,
);

const kWhiteTextStyle = TextStyle(
  color: Colors.white,
);

const kStandardStyle = TextStyle(fontSize: 16);

const kHistoryRecordTitle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 16,
);

const kHistoryExpenseValue = TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.w700,
  fontSize: 16,
);

const kHistoryIncomeValue = TextStyle(
  color: Colors.green,
  fontWeight: FontWeight.w700,
  fontSize: 16,
);

const kHistoryRecordDate = TextStyle(
  color: Colors.grey,
  fontSize: 12,
);
