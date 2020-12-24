import 'dart:io';

import 'package:LibraryManagmentSystem/providers/library_provider.dart';
import 'package:LibraryManagmentSystem/screens/regestration/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './theme.dart';
import 'providers/user-provider.dart';

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
        home: WelcomeScreen(),
      ),
    );
  }
}
