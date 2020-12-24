import 'package:flutter/material.dart';

dynamic ourDialog({BuildContext context, String error, Widget button2}) {
  return showDialog(
      context: context,
      child: AlertDialog(
        content: Text(error),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ok'),
          ),
          button2
        ],
      ));
}
