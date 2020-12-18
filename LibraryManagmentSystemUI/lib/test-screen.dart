import 'package:flutter/material.dart';

class TestComponnets extends StatefulWidget {
  @override
  _TestComponnetsState createState() => _TestComponnetsState();
}

class _TestComponnetsState extends State<TestComponnets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(26.0),
            child: RaisedButton(
              onPressed: () {},
              child: Text(
                "Log in",
                style: Theme.of(context).textTheme.button,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
          )
        ],
      ),
    );
  }
}
