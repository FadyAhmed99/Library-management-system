import './test-screen.dart';
import 'package:flutter/material.dart';
import './theme.dart';
import './drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library Managment System',
      theme: mainTheme,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: drawer(context),
        appBar: AppBar(
          title: Text("Library"),
          actions: [
            FittedBox(
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TestComponnets()));
                },
                child: Text("Test Components"),
                color: Colors.amber,
              ),
            )
          ],
        ),
        body: Text("Home"));
  }
}
