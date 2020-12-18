import 'package:flutter/material.dart';

dynamic myDialog({BuildContext context, String err}) {
  return showDialog(
      context: context,
      child: AlertDialog(
        content: Text(err),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ok'),
          )
        ],
      ));
}
