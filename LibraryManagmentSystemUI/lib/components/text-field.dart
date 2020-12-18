import 'package:flutter/material.dart';

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
    decoration:
        myTextFieldDecoration(context: context, hint: hint, label: label),
    textAlign: TextAlign.center,
  );
}
