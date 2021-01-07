import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryMembersScreen extends StatefulWidget {
  String libraryId;

  LibraryMembersScreen({
    this.libraryId,
  });
  @override
  _LibraryMembersScreenState createState() => _LibraryMembersScreenState();
}

class _LibraryMembersScreenState extends State<LibraryMembersScreen> {
  bool _loading = true;
  bool _init = true;
  List<UserSerializer> _members = [];
  @override
  void didChangeDependencies() {
    if (_init) {
      final _libraryProvider = Provider.of<Library>(context);
      _libraryProvider
          .getLibraryMembers(libraryId: widget.libraryId)
          .then((err) {
        if (err != null)
          ourDialog(context: context, error: err);
        else {
          _members = _libraryProvider.members;
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

    void setPermission(
        int index, String action, String from, String message, void fn) {
      _libraryProvider
          .setUserPermissions(
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

    return _loading
        ? loading()
        : RefreshIndicator(
            onRefresh: () async {
              await _libraryProvider.getLibraryMembers(
                  libraryId: widget.libraryId);
            },
            child: ListView.builder(
                itemCount: _members.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 10, color: Colors.green),
                          borderRadius: BorderRadius.all(
                            Radius.circular(300),
                          )),
                      tileColor: Theme.of(context).cardColor,
                      contentPadding: kListTilePadding,
                      leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child:
                              userImage(image: _members[index].profilePhoto)),
                      title: Text(_members[index].firstname +
                          ' ' +
                          _members[index].lastname),
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
                              height: 1,
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
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
                                            'borrowing',
                                            'can borrow again',
                                            _members[index].canBorrowItems =
                                                true);
                                      }
                                    },
                                    child: Text(_members[index].canBorrowItems
                                        ? 'Prevent From Borrowing Items'
                                        : 'Allow Borrowing Items'))),
                            PopupMenuItem(
                              height: 1,
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            PopupMenuItem(
                                child: InkWell(
                                    onTap: () {
                                      ourDialog(
                                          context: context,
                                          btn1: "back",
                                          error:
                                              'Are you sure you want to remove\n ${_members[index].firstname} ${_members[index].lastname} from library?',
                                          button2: FlatButton(
                                            child: Text("Remove"),
                                            onPressed: () async {
                                              Navigator.pop(context);

                                              await _libraryProvider
                                                  .librarianRejectRequest(
                                                      libraryId:
                                                          widget.libraryId,
                                                      userId:
                                                          _members[index].id)
                                                  .then((err) {
                                                if (err == null) {
                                                  _members.removeAt(index);
                                                  Navigator.pop(context);
                                                  Scaffold.of(context)
                                                      .showSnackBar(SnackBar(
                                                    duration:
                                                        Duration(seconds: 3),
                                                    content: Text(
                                                        "${_members[index].firstname} ${_members[index].lastname} Member removed"),
                                                  ));
                                                } else {
                                                  ourDialog(
                                                      context: context,
                                                      error: err);
                                                }
                                              });
                                            },
                                          ));
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
