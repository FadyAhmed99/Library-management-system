import 'package:flutter/material.dart';
import 'package:LibraryManagmentSystem/constants.dart';


TextFormField myTextFormField({
  BuildContext context,
  String hint,
  String label,
  Function validator,
  TextEditingController controller,
  TextInputType textInputType,
  bool obsecure = false,
}) {
  return TextFormField(
    obscureText: obsecure,
    validator: validator,
    controller: controller,
    keyboardType: textInputType,
    decoration: kTextFieldDecoration.copyWith(labelText: label, hintText: hint),
    // myTextFieldDecoration(context: context, hint: hint, label: label),
    textAlign: TextAlign.center,
  );
}
