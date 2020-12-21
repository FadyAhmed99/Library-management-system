import 'dart:io';

import 'package:LibraryManagmentSystem/provider/library_provider.dart';
import 'package:LibraryManagmentSystem/screen/libraries.dart';
import 'package:LibraryManagmentSystem/screen/my_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './drawer.dart';
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
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => LibraryProvider())
      ],
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
  String token = '';
  bool _loading = false;
  bool _init = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      final _userProvider = Provider.of<UserProvider>(context);
      _userProvider.facebookLogin.currentAccessToken.then((value) {
        if (value != null && value.isValid()) {
          _userProvider.logInFacebookUser(value.token).then((value) {});
        }
        setState(() {
          _init = false;
        });
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        title: Text("Library"),
      ),
      body: MyTest(),
    );
  }
}
