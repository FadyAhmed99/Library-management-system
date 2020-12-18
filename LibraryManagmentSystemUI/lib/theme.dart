import 'package:flutter/material.dart';

ThemeData mainTheme = ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.white,
  buttonColor: Colors.blue[500],
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.grey[300],
  visualDensity: VisualDensity.adaptivePlatformDensity,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.accent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    disabledColor: Colors.grey,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(fontSize: 14, color: Colors.black),
    bodyText2: TextStyle(fontSize: 16, color: Colors.black),
    headline1: TextStyle(
        fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
    headline2: TextStyle(
        fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
    headline3: TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
    button: TextStyle(fontSize: 16, color: Colors.white),
    caption: TextStyle(fontSize: 14, color: Colors.black),
    subtitle1: TextStyle(fontSize: 14, color: Colors.grey),
    subtitle2: TextStyle(fontSize: 12, color: Colors.grey),
  ),
);
