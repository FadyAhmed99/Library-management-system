import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class ViewPDF extends StatefulWidget {
  final String fileLink;
  final String title;
  ViewPDF({this.fileLink, this.title});

  @override
  _ViewPDFState createState() => _ViewPDFState();
}

class _ViewPDFState extends State<ViewPDF> {
  bool _isLoading = true;
  PDFDocument document;
  bool _errMsg = false;
  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromURL(
      widget.fileLink,
    ).catchError((err) {
      setState(() => _errMsg = true);
    });
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: widget.title, backTheme: false, context: context),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _errMsg
                ? Text('Error loading this file')
                : PDFViewer(
                    document: document,
                    zoomSteps: 1,
                  ),
      ),
    );
  }
}
