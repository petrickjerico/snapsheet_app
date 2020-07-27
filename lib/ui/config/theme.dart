import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData kTheme = ThemeData.dark().copyWith(
    primaryColor: kCyan,
    backgroundColor: kScaffoldBackgroundColour,
    scaffoldBackgroundColor: kScaffoldBackgroundColour);

ColorScheme kFirstColorScheme = ColorScheme(
  primary: kNavyBluePrimary,
  primaryVariant: kNavyBluePrimaryVariant,
  secondary: kMintSecondary,
  secondaryVariant: kMintSecondaryVariant,
  surface: Colors.white,
  background: kLightBlueBackground,
  error: Colors.red[700],
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onBackground: Colors.black,
  onSurface: Colors.black,
  brightness: Brightness.light,
);
