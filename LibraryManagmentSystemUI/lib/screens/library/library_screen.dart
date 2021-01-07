import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/drawer.dart';
import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';

import 'package:LibraryManagmentSystem/screens/library/library_admin_panel.dart';
import 'package:LibraryManagmentSystem/screens/library/library_info_screen.dart';
import 'package:LibraryManagmentSystem/screens/library/library_items_screen.dart';
import 'package:LibraryManagmentSystem/screens/library/library_members_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatefulWidget {
  final String libraryId;
  int page;

  LibraryScreen({this.libraryId, this.page = 0});
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  bool _init = true;
  bool _loading = true;
  LibrarySerializer _library;

  @override
  void didChangeDependencies() {
    if (_init) {
      final _libraryProvider = Provider.of<Library>(context);
      _libraryProvider.getLibraryInfo(libraryId: widget.libraryId).then((err) {
        if (err != null) {
          ourDialog(error: err, context: context);
        } else {
          _library = _libraryProvider.library;
          setState(() {
            _loading = false;
          });
        }
      });
      _init = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<User>(context);
    final _libraryProvider = Provider.of<Library>(context);

    _library = _libraryProvider.library;

    UserSerializer _user = _userProvider.user;
    return _loading
        ? Scaffold(body: loading())
        : _user.id == _libraryProvider.librarian.id
            ? DefaultTabController(
                initialIndex: widget.page,
                length: 4,
                child: Scaffold(
                  drawer: drawer(context),
                  appBar: appBar(
                    context: context,
                    backTheme: true,
                    bottom: TabBar(isScrollable: true, tabs: [
                      Text('Library Items'),
                      Text('Library Info'),
                      Text('Members'),
                      Text('Admin Panel'),
                    ]),
                    title: _loading ? '' : _library.name,
                  ),
                  body: _loading
                      ? loading()
                      : TabBarView(children: [
                          LibraryItemsScreen(libraryId: widget.libraryId),
                          LibraryInfoScreen(libraryId: _library.id),
                          LibraryMembersScreen(libraryId: _library.id),
                          LibraryAdminPanelScreen(_library.id)
                        ]),
                ),
              )
            : DefaultTabController(
                length: 2,
                child: Scaffold(
                  drawer: drawer(context),
                  appBar: appBar(
                    context: context,
                    backTheme: true,
                    bottom: TabBar(tabs: [
                      Text('Library Items'),
                      Text('Library Info'),
                    ]),
                    title: _loading ? '' : _library.name,
                  ),
                  body: _loading
                      ? loading()
                      : TabBarView(children: [
                          LibraryItemsScreen(libraryId: widget.libraryId),
                          LibraryInfoScreen(libraryId: _library.id),
                        ]),
                ),
              );
  }
}
