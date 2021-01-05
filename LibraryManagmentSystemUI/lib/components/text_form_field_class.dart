import 'package:flutter/material.dart';

class KFormField {
  String label;
  String hint;
  Function validator;
  TextEditingController controller;
  TextInputType textInputType;
  bool obsecure;
  KFormField(
      {this.label,
      this.hint,
      this.validator,
      this.controller,
      this.textInputType = TextInputType.text,
      this.obsecure = false});
}
