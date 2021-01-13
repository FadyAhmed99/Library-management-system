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

TableRow emptyRow({double height = 25}) {
  return TableRow(children: [
    Container(height: height),
    Container(height: height),
  ]);
}
