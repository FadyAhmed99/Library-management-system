import 'package:flutter/material.dart';
import 'package:LibraryManagmentSystem/constants.dart';
InputDecoration myTextFieldDecoration(
    {BuildContext context, String hint, String label}) {
  return InputDecoration(
    hintText: hint,
    labelText: label,
    labelStyle: Theme.of(context).textTheme.headline1,
  );
}

TextFormField myTextFormField(
    BuildContext context, String hint, String label, Function validator) {
  return TextFormField(
    decoration: kTextFieldDecoration.copyWith(labelText: label, hintText: hint),
        // myTextFieldDecoration(context: context, hint: hint, label: label),
    textAlign: TextAlign.center,
  );
}
