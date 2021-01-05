import 'dart:ui';

import 'package:flutter/material.dart';

class RoundedCard extends StatefulWidget {
  String data;
  String label;
  bool edit;
  TextEditingController controller;
  Function validator;
  RoundedCard({
    this.data = '',
    this.label = '',
    this.edit = false,
    this.controller,
    this.validator,
  });

  @override
  _RoundedCardState createState() => _RoundedCardState();
}

class _RoundedCardState extends State<RoundedCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(widget.label,
                  style: Theme.of(context).textTheme.headline1),
            ),
          ),
          TextFormField(
            enabled: widget.edit,
            keyboardType:
                widget.label == 'phone number' ? TextInputType.number : null,
            controller: widget.controller,
            validator: widget.validator,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              fillColor: Colors.white,
              filled: true,
              focusColor: Colors.white,
              hoverColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.red),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
