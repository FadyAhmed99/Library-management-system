import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './drawer.dart';
import './test-screen.dart';
import './theme.dart';
import 'provider/user-provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
        child: MaterialApp(
    title: 'Library Managment System',
    theme: mainTheme,
    home: MyHomePage(),
        ),
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
