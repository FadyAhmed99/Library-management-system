import 'package:flutter/material.dart';

dynamic ourDialog(
    {@required BuildContext context,
    String error,
    String btn1 = 'ok',
    Widget button2}) {
  return showDialog(
      context: context,
      child: AlertDialog(
        content: Text(error),
        actions: [
          button2,
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text(btn1),
          ),
        ],
      ));
}
