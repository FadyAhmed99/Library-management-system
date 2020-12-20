import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget ourAuthButton({Widget child, Function function}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
    child: RaisedButton(
      onPressed: function,
      child: child,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
