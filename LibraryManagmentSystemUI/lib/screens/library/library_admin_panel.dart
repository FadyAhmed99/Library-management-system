import 'package:LibraryManagmentSystem/providers/library_provider.dart';
import 'package:LibraryManagmentSystem/screens/library/pending_requests/pending_requests_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'library_members_screen.dart';

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
    final _libraryProvider =
        Provider.of<LibraryProvider>(context, listen: false);
    Map<String, dynamic> tiles = {
      'Pending Requests': PendingRequests(widget.libraryId),
      'Statistical Report': 'dsa',
      'Prevented From Reviewing Items': LibraryMembersScreen(
        borrowBtn: false,
        removeBtn: false,
        reviewBtn: true,
        libraryId: widget.libraryId,
        fn: _libraryProvider.getBlockedFromReviewing(
            libraryId: widget.libraryId),
      ),
      'Prevented From Borrowing Items': 'dsa'
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
