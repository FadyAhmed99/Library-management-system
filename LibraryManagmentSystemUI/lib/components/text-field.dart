import 'package:flutter/material.dart';
import 'package:LibraryManagmentSystem/constants.dart';


TextFormField myTextFormField({
  Key key,
  BuildContext context,
  String hint,
  String label,
  Function validator,
  TextEditingController controller,
  TextInputType textInputType,
  bool obsecure = false,
}) {
  return TextFormField(
    key: key,
    obscureText: obsecure,
    validator: validator,
    controller: controller,
    keyboardType: textInputType,
    decoration: kTextFieldDecoration.copyWith(labelText: label, hintText: hint),
    // myTextFieldDecoration(context: context, hint: hint, label: label),
    textAlign: TextAlign.center,
  );
}
