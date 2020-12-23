import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/model/library.dart';
import 'package:LibraryManagmentSystem/provider/library_provider.dart';
import 'package:LibraryManagmentSystem/provider/user-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTest extends StatefulWidget {
  @override
  _MyTestState createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  @override
  Widget build(BuildContext context) {
    final _libraryProvider = Provider.of<LibraryProvider>(context);
    final _userProvider = Provider.of<UserProvider>(context);
    String token = _userProvider.token;
    List<Library> _lib = _libraryProvider.libraries;
    _libraryProvider
        .getLibraryRequests(libraryId: "5fdfc30bc8d9a8038b39ed3c")
        .then((value) {
      if (value!=null) {
        return ourDialog(context: context, error: value);
      }
    });
    return Container();
  }
}
