import 'package:flutter/material.dart';

const kTitleEditInfoInputDecoration = InputDecoration(
  border: OutlineInputBorder(),
  focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
  labelText: "Title",
  labelStyle: TextStyle(color: Colors.white),
);

const kBottomSheetShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(15.0),
    topRight: Radius.circular(15.0),
  ),
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

const kAddAccountTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.grey),
  hintText: 'Name your new account',
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
  ),
);

const kEmailTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.grey),
  hintText: 'Email',
  prefixIcon: Icon(Icons.email),
);

const kPasswordTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.grey),
  hintText: 'Password',
  prefixIcon: Icon(Icons.search),
);

const kConfirmPasswordTextFieldDecoration = InputDecoration(
    hintStyle: TextStyle(color: Colors.grey),
    hintText: 'Confirm Password',
    prefixIcon: Icon(Icons.youtube_searched_for));
