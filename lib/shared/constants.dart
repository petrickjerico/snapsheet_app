import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle kWelcomeTextStyle = GoogleFonts.lato(
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
  letterSpacing: 4,
);

const kWhiteTextStyle = TextStyle(
  color: Colors.white,
);

const kBlack = Color(0xFF262834);
const kLightBlueGrey = Color(0xFFD8F1F5);
const kCyan = Color(0xFF56CBDC);
const kDarkCyan = Color(0xFF5991A0);
const kGrey = Color(0xFFACABAF);

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

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecorationLogin = InputDecoration(
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  hintText: 'Email',
);
