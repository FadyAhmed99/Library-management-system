import 'package:flutter/material.dart';

Widget appBar({String title, bool backTheme, BuildContext context}) {
  return AppBar(
    title: Text(title),
    automaticallyImplyLeading: backTheme,
    centerTitle: true,
    leading: InkWell(
      child: Icon(Icons.arrow_back),
      onTap: () => Navigator.pop(context),
    ),
  );
}
