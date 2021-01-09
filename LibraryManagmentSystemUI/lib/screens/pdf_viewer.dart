import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:flutter/material.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class ViewPDF extends StatefulWidget {
  final String fileLink;
  final String title;
  ViewPDF({this.fileLink, this.title});

  @override
  _ViewPDFState createState() => _ViewPDFState();
}

class _ViewPDFState extends State<ViewPDF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(backTheme: false, title: widget.title, context: context),
      body: PDF.network(
        widget.fileLink,
        width: double.infinity,
        height: double.infinity,
        placeHolder: loading(),
      ),
    );
  }
}
