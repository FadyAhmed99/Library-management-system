import 'package:flutter/material.dart';

Widget loading() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
        child: CircularProgressIndicator(
      backgroundColor: Colors.blue[700],
      strokeWidth: 3,
    )),
  );
}
