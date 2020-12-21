import 'package:LibraryManagmentSystem/models/library.dart';
import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  final Library library;
  LibraryScreen({this.library});
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.library.address),
        centerTitle: true,
      ),
    );
  }
}
