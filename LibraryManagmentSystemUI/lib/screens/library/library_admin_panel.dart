import 'package:LibraryManagmentSystem/screens/drawer/admin_panel_screen.dart';
import 'package:LibraryManagmentSystem/screens/library/pending_requests/pending_requests_screen.dart';
import 'package:LibraryManagmentSystem/screens/library/prevented_from_borrowing_screen.dart';
import 'package:LibraryManagmentSystem/screens/library/prevented_from_evaluate_screen.dart';
import 'package:flutter/material.dart';

class LibraryAdminPanelScreen extends StatefulWidget {
  final String libraryId;
  const LibraryAdminPanelScreen(this.libraryId);

  @override
  _LibraryAdminPanelScreenState createState() =>
      _LibraryAdminPanelScreenState();
}

class _LibraryAdminPanelScreenState extends State<LibraryAdminPanelScreen> {
  @override
  Widget build(BuildContext context) {
 
    Map<String, dynamic> tiles = {
      'Pending Requests': PendingRequests(widget.libraryId),
      'Statistical Report': AdminPanelScreen(),
      'Prevented From Reviewing Items':
          PreventedFromEvaluateScreen(libraryId: widget.libraryId),
      'Prevented From Borrowing Items':
          PreventedFromBorrowingScreen(libraryId: widget.libraryId),
    };
    return ListView(
        children: tiles.entries.map((e) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => e.value));
          },
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(e.key,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontWeight: FontWeight.normal)),
              ),
            ),
          ),
        ),
      );
    }).toList());
  }
}
