import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/screens/library/pending_requests/borrowing_screen.dart';
import 'package:LibraryManagmentSystem/screens/library/pending_requests/joning_screen.dart';
import 'package:LibraryManagmentSystem/screens/library/pending_requests/returning_screen.dart';
import 'package:flutter/material.dart';

class PendingRequests extends StatefulWidget {
  final String libraryId;
  PendingRequests(this.libraryId);
  @override
  _PendingRequestsState createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: appBar(
              title: 'Pending Requests',
              context: context,
              backTheme: false,
              bottom: TabBar(
                tabs: [Text('Joining'), Text('Borrowing'), Text('Returning')],
              ),
            ),
            body: TabBarView(children: [
              JoiningScreen(widget.libraryId),
              BorrowingScreen(widget.libraryId),
              ReturningScrren(widget.libraryId),
            ])));
  }
}
