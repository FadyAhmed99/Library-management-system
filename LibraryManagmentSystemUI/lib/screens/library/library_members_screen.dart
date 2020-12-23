import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/constants.dart';
import 'package:LibraryManagmentSystem/models/user.dart';
import 'package:LibraryManagmentSystem/providers/library_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryMembersScreen extends StatefulWidget {
  String libraryId;
  Future<dynamic> fn;
  final bool removeBtn;
  final bool borrowBtn;
  final bool reviewBtn;
  LibraryMembersScreen(
      {this.libraryId,
      this.fn,
      this.removeBtn,
      this.borrowBtn,
      this.reviewBtn});
  @override
  _LibraryMembersScreenState createState() => _LibraryMembersScreenState();
}

class _LibraryMembersScreenState extends State<LibraryMembersScreen> {
  bool _loading = true;
  bool _init = true;
  List<User> _members = [];
  @override
  void didChangeDependencies() {
    final _libraryProvider = Provider.of<LibraryProvider>(context);
    widget.fn.then((err) {
      if (err != null)
        ourDialog(context: context, error: err);
      else {
        _members = _libraryProvider.blockedFromReviewing;
        setState(() {
          _loading = false;
        });
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _libraryProvider = Provider.of<LibraryProvider>(context);

    void setPermission(
        int index, String action, String from, String message, void fn) {
      _libraryProvider
          .setPermissions(
              libraryId: widget.libraryId,
              userId: _members[index].id,
              action: action,
              from: from)
          .then((err) {
        if (err == null) {
          setState(() => fn);
          Navigator.pop(context);
          Scaffold.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              content: Text(
                  '${_members[index].firstname} ${_members[index].firstname} $message')));
        } else {
          // fn();
          ourDialog(context: context, error: err);
        }
      });
    }

    return Scaffold(
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
                                    if (_members[index].canEvaluateItems) {
                                      setPermission(
                                          index,
                                          'block',
                                          'evaluating',
                                          'can\'t review any more',
                                          _members[index].canEvaluateItems =
                                              false);
                                    } else {
                                      setPermission(
                                          index,
                                          'unblock',
                                          'evaluating',
                                          'can review again',
                                          _members[index].canEvaluateItems =
                                              true);
                                    }
                                  },
                                  child: Text(_members[index].canEvaluateItems
                                      ? 'Prevent From Reviewing Items'
                                      : 'Allow Reviewing Items'))),
                          PopupMenuItem(
                              child: InkWell(
                                  onTap: () {
                                    if (_members[index].canBorrowItems) {
                                      setPermission(
                                          index,
                                          'block',
                                          'borrowing',
                                          'can\'t borrow any more',
                                          _members[index].canBorrowItems =
                                              false);
                                    } else {
                                      setPermission(
                                          index,
                                          'unblock',
                                          'evaluating',
                                          'can borrow again',
                                          _members[index].canBorrowItems =
                                              true);
                                    }
                                  },
                                  child: Text(_members[index].canBorrowItems
                                      ? 'Prevent From Borrowing Items'
                                      : 'Allow Borrowing Items'))),
                          PopupMenuItem(
                              child: InkWell(
                                  onTap: () {
                                    _libraryProvider
                                        .libraryRejectRequest(
                                            libraryId: widget.libraryId,
                                            userId: _members[index].id)
                                        .then((err) {
                                      setState(() {
                                        _members.removeAt(index);
                                      });
                                      Navigator.pop(context);
                                      ourDialog(context: context, error: err);
                                    });
                                  },
                                  child: Text('Remove From Library'))),
                        ];
                      },
                    ),
                  ),
                );
              }),
    );
  }
}
