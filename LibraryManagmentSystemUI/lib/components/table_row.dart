import 'package:flutter/material.dart';

TableRow row(String label, String data, BuildContext context) {
  return TableRow(children: [
    Text(
      label + ': ',
      style: Theme.of(context)
          .textTheme
          .headline1
          .copyWith(fontWeight: FontWeight.normal),
    ),
    Text(data ?? '',
        style: Theme.of(context)
            .textTheme
            .headline1
            .copyWith(color: Colors.black, fontWeight: FontWeight.normal)),
  ]);
}

TableRow emptyRow() {
  return TableRow(children: [
    Container(height: 25),
    Container(height: 25),
  ]);
}
