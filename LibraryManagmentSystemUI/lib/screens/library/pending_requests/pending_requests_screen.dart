import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/models/user.dart';
import 'package:LibraryManagmentSystem/providers/library_provider.dart';
import 'package:LibraryManagmentSystem/screens/library/pending_requests/joning_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class PendingRequests extends StatefulWidget {
  String libraryId;
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
            appBar: AppBar(
              title: Text('Pending Requests'),
              centerTitle: true,
              bottom: TabBar(
                tabs: [Text('Joining'), Text('Borrowing'), Text('Returning')],
              ),
            ),
            body: TabBarView(children: [
              JoiningScreen(widget.libraryId),
              JoiningScreen(widget.libraryId),
              JoiningScreen(widget.libraryId),
            ])));
  }
}
