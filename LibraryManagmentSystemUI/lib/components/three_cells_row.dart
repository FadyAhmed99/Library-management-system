import 'package:flutter/material.dart';

TableRow threeRows({String firstLabel, String secondLabel, String thirdLabel}) {
  return TableRow(children: [
    Text(firstLabel ?? '', textAlign: TextAlign.center),
    Text(secondLabel ?? '', textAlign: TextAlign.center),
    Text(thirdLabel ?? '', textAlign: TextAlign.center),
  ]);
}

TableRow threeRowsTitle(
    {String firstLabel,
    String secondLabel,
    String thirdLabel,
    BuildContext context,
    TextStyle style}) {
  style = Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 14);
  return TableRow(children: [
    Text(firstLabel ?? '', textAlign: TextAlign.center, style: style),
    Text(secondLabel ?? '', textAlign: TextAlign.center, style: style),
    Text(thirdLabel ?? '', textAlign: TextAlign.center, style: style),
  ]);
}

TableRow threeChecks(bool firstIcon, bool secondIcon, bool thirdIcon,
    {BuildContext context}) {
  return TableRow(children: [
    firstIcon
        ? Icon(
            Icons.check,
            color: Colors.blue,
          )
        : Container(),
    secondIcon
        ? Icon(
            Icons.check,
            color: Colors.blue,
          )
        : Container(),
    thirdIcon
        ? Icon(
            Icons.check,
            color: Colors.blue,
          )
        : Container(),
  ]);
}

TableRow threeEmptyRows(double space) {
  return TableRow(children: [
    Container(height: space),
    Container(height: space),
    Container(height: space),
  ]);
}
