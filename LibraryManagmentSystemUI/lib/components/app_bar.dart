import 'package:LibraryManagmentSystem/screens/search_results_screen.dart';
import 'package:LibraryManagmentSystem/screens/search_screen.dart';
import 'package:flutter/material.dart';

Widget appBar(
    {String title,
    bool backTheme,
    BuildContext context,
    PreferredSizeWidget bottom}) {
  return AppBar(
    bottom: bottom,
    title: Text(
      title,
      style:
          Theme.of(context).textTheme.headline3.copyWith(color: Colors.white),
    ),
    actions: [
      backTheme
          ? Padding(
              padding: EdgeInsets.all(18),
              child: InkWell(
                child: Icon(Icons.search),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
              ),
            )
          : Container()
    ],
    automaticallyImplyLeading: backTheme,
    centerTitle: true,
    leading: !backTheme
        ? InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () => Navigator.pop(context),
          )
        : null,
  );
}
