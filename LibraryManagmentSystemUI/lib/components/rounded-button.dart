import 'dart:ui';

import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.title, @required this.onPressed});
  final String title;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
    );
  }
}
