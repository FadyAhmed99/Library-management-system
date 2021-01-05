import 'package:flutter/material.dart';

ThemeData mainTheme = ThemeData(
  brightness: Brightness.light,
  tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      labelPadding: EdgeInsets.all(8),
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      unselectedLabelStyle:
          TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
  primaryIconTheme: IconThemeData(color: Colors.white),
  hintColor: Colors.grey[600],
  // primaryTextTheme: TextTheme(
  //   headline6: TextStyle(color: Colors.white),
  // ),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.white),
  primarySwatch: Colors.lightBlue,
  accentColor: Colors.blue,
  backgroundColor: Colors.white,
  indicatorColor: Colors.white,
  buttonColor: Colors.lightBlue,

  scaffoldBackgroundColor: Colors.grey[300],
  visualDensity: VisualDensity.adaptivePlatformDensity,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    disabledColor: Colors.grey,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(fontSize: 14, color: Colors.grey[900]),
    bodyText2: TextStyle(fontSize: 16),
    headline1: TextStyle(
        fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.w600),
    headline2: TextStyle(
        fontSize: 18, color: Colors.grey[900], fontWeight: FontWeight.bold),
    headline3: TextStyle(
        fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
    headline4: TextStyle(
        fontSize: 20, color: Colors.grey[900], fontWeight: FontWeight.bold),
    button: TextStyle(fontSize: 16, color: Colors.white),
    caption: TextStyle(fontSize: 14, color: Colors.black),
    subtitle1: TextStyle(fontSize: 20, color: Colors.grey[900]),
    subtitle2: TextStyle(fontSize: 12, color: Colors.grey),
  ),
);
