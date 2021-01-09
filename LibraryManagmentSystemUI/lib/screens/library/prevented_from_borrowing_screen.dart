import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/constants.dart';
import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreventedFromBorrowingScreen extends StatefulWidget {
  final String libraryId;

  PreventedFromBorrowingScreen({
    this.libraryId,
  });
  @override
  _PreventedFromBorrowingScreenState createState() =>
      _PreventedFromBorrowingScreenState();
}

class _PreventedFromBorrowingScreenState
    extends State<PreventedFromBorrowingScreen> {
  bool _loading = true;
  bool _init = true;
  List<UserSerializer> _members = [];
  @override
  void didChangeDependencies() {
    if (_init) {
      final _libraryProvider = Provider.of<Library>(context);
      _libraryProvider
          .getBlockedUsersFromBorrowing(libraryId: widget.libraryId)
          .then((err) {
        if (err != null)
          ourDialog(context: context, error: err);
        else {
          _members = _libraryProvider.blockedFromBorrowing;
          setState(() {
            _loading = false;
          });
        }
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _libraryProvider = Provider.of<Library>(context);

    void setPermission(int index, String action, String from, String message) {
      _libraryProvider
          .setUserPermissions(
              libraryId: widget.libraryId,
              userId: _members[index].id,
              action: action,
              from: from)
          .then((err) {
        if (err == null) {
          Navigator.pop(context);
          setState(() {
            _members.removeAt(index);
          });
          // Scaffold.of(context).showSnackBar(SnackBar(
          //     duration: Duration(seconds: 1),
          //     content: Text(
          //         '${_members[index].firstname} ${_members[index].firstname} $message')));
        } else {
          ourDialog(context: context, error: err);
        }
      });
    }

    return Scaffold(
      appBar: appBar(
          title: 'Prevented From Borrowing',
          backTheme: false,
          context: context),
      body: _loading
          ? loading()
          : ListView.builder(
              itemCount: _members.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: kListTileMargin,
                  child: ListTile(
                    tileColor: Theme.of(context).cardColor,
                    contentPadding: kListTilePadding,
                    leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: userImage(image: _members[index].profilePhoto)),
                    title: Text(
                        _members[index].firstname + _members[index].lastname),
                    trailing: PopupMenuButton(
                      color: Theme.of(context).dialogBackgroundColor,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                              child: InkWell(
                                  onTap: () {
                                    setPermission(
                                      index,
                                      'unblock',
                                      'borrowing',
                                      'can borrow again',
                                    );
                                  },
                                  child: Text('Allow Borrowing Items'))),
                        ];
                      },
                    ),
                  ),
                );
              }),
    );
  }
}
