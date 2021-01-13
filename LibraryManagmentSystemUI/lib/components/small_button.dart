import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  SmallButton({@required this.child, @required this.onPressed});

  final Widget child;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: child);
  }
}
