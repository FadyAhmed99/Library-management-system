import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

SliverGridDelegateWithMaxCrossAxisExtent kGridShape(
    {@required BuildContext context}) {
  return SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
    childAspectRatio: 0.75, 
  );
}

const kListTilePadding = EdgeInsets.all(8);
const kListTileMargin = EdgeInsets.all(8);
const kUserPlaceholder = AssetImage('assets/images/user.png');
const kLibraryPlaceholder = AssetImage('assets/images/library.png');
const kItemPlaceholder = AssetImage('assets/images/book.png');
const kLogo = 'assets/images/app-logo1.png';