import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class JoiningScreen extends StatefulWidget {
  final String libraryId;
  JoiningScreen(this.libraryId);
  @override
  _JoiningScreenState createState() => _JoiningScreenState();
}

class _JoiningScreenState extends State<JoiningScreen> {
  bool _init = true;
  List<UserSerializer> _requests;
  @override
  void didChangeDependencies() {
    if (_init) {
      final _libraryProvider = Provider.of<Library>(context);
      _libraryProvider
          .getLibraryJoinRequests(libraryId: widget.libraryId)
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
    final _libraryProvider = Provider.of<Library>(context);

    return _requests == null
        ? loading()
        : ListView.builder(
            itemCount: _requests.length,
            itemBuilder: (context, index) {
              return Container(
                margin: kListTileMargin,
                child: ListTile(
                  contentPadding: kListTilePadding,
                  tileColor: Theme.of(context).cardColor,
                  leading: userImage(image: _requests[index].profilePhoto),
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
                                    .librarianAcceptRequest(
                                        libraryId: widget.libraryId,
                                        userId: _requests[index].id)
                                    .then((status) {
                                  setState(() {
                                    _requests.removeAt(index);
                                  });
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Request approved')));
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
                                    .librarianRejectRequest(
                                        libraryId: widget.libraryId,
                                        userId: _requests[index].id)
                                    .then((status) {
                                  setState(() {
                                    _requests.removeAt(index);
                                  });
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Request rejected')));
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
            });
  }
}
