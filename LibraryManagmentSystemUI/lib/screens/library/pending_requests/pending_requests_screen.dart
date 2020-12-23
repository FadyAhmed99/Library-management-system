import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/models/user.dart';
import 'package:LibraryManagmentSystem/providers/library_provider.dart';
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
  bool _init = true;
  List<User> _requests;

  @override
  void didChangeDependencies() {
    if (_init) {
      final _libraryProvider = Provider.of<LibraryProvider>(context);
      _libraryProvider
          .getLibraryRequests(libraryId: widget.libraryId)
          .then((err) {
        if (err != null) {
          ourDialog(context: context, error: err);
        } else {
          _requests = _libraryProvider.requests;
        }
      });
      _init = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _libraryProvider = Provider.of<LibraryProvider>(context);

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
          body: _requests == null
              ? loading()
              : ListView.builder(
                  itemCount: _requests.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: kListTileMargin,
                      child: ListTile(
                        contentPadding: kListTilePadding,
                        tileColor: Theme.of(context).cardColor,
                        leading:
                            userImage(image: _requests[index].profilePhoto),
                        title: Text(_requests[index].firstname +
                            ' ' +
                            _requests[index].lastname),
                        trailing: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                                child: InkWell(
                                    onTap: () {
                                      _libraryProvider
                                          .libraryAcceptRequest(
                                              libraryId: widget.libraryId,
                                              userId: _requests[index].id)
                                          .then((status) {
                                        setState(() {
                                          _requests.removeAt(index);
                                        });
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(content: Text(status)));
                                      });
                                    },
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 30,
                                    ))),
                            SizedBox(width: 25),
                            Center(
                                child: InkWell(
                                    onTap: () {
                                      _libraryProvider
                                          .libraryRejectRequest(
                                              libraryId: widget.libraryId,
                                              userId: _requests[index].id)
                                          .then((status) {
                                        setState(() {
                                          _requests.removeAt(index);
                                        });
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(content: Text(status)));
                                      });
                                    },
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.red,
                                      size: 30,
                                    ))),
                          ],
                        ),
                      ),
                    );
                  }),
        ));
  }
}
