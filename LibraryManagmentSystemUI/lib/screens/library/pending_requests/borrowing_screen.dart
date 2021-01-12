import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/small_button.dart';
import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/classes/borrow_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class BorrowingScreen extends StatefulWidget {
  final String libraryId;
  BorrowingScreen(this.libraryId);
  @override
  _BorrowingScreenState createState() => _BorrowingScreenState();
}

class _BorrowingScreenState extends State<BorrowingScreen> {
  bool _init = true;
  List<BorrowRequestSerializer> _requests;
  @override
  void didChangeDependencies() {
    if (_init) {
      final _borrowRequestProvider = Provider.of<BorrowRequest>(context);
      _borrowRequestProvider
          .getLibraryBorrowRequests(libraryId: widget.libraryId)
          .then((err) {
        if (err != null) {
          ourDialog(context: context, error: err);
        } else {
          _requests = _borrowRequestProvider.requests;
        }
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _borrowRequestProvider = Provider.of<BorrowRequest>(context);
    return _requests == null
        ? loading()
        : RefreshIndicator(
            onRefresh: () async {
              await _borrowRequestProvider.getLibraryBorrowRequests(
                  libraryId: widget.libraryId);
            },
            child: ListView.builder(
                itemCount: _requests.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: kListTileMargin,
                    child: ListTile(
                        contentPadding: kListTilePadding,
                        tileColor: Theme.of(context).cardColor,
                        leading: userImage(
                            image: _requests[index].user.profilePhoto),
                        title: Text(_requests[index].user.firstname +
                            ' ' +
                            _requests[index].user.lastname),
                        subtitle: Text(
                          "Item Name: ${_requests[index].item.name}",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        trailing: SmallButton(
                          onPressed: () {
                            _borrowRequestProvider
                                .grantLibraryBorrowRequest(
                                    libraryId: widget.libraryId,
                                    requestId: _requests[index].id)
                                .then((err) {
                              if (err != null)
                                ourDialog(
                                    context: context, error: err, btn1: 'Ok');
                              else {
                                setState(() {
                                  _requests.removeAt(index);
                                });
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Item received'),
                                  duration: Duration(seconds: 3),
                                ));
                              }
                            });
                          },
                          child: Text('Grant'),
                        )),
                  );
                }),
          );
  }
}
