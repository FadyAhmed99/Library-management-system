import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/models/library.dart';
import 'package:LibraryManagmentSystem/models/user.dart';
import 'package:LibraryManagmentSystem/providers/library_provider.dart';
import 'package:LibraryManagmentSystem/providers/user-provider.dart';
import 'package:LibraryManagmentSystem/screens/library/library_admin_panel.dart';
import 'package:LibraryManagmentSystem/screens/library/library_info_screen.dart';
import 'package:LibraryManagmentSystem/screens/library/library_items_screen.dart';
import 'package:LibraryManagmentSystem/screens/library/library_members_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatefulWidget {
  final String libraryId;
  LibraryScreen({this.libraryId});
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  bool _init = true;
  bool _loading = true;
  Library _library;
  ScrollController _scrollController = ScrollController();
  @override
  void didChangeDependencies() {
    if (_init) {
      final _libraryProvider = Provider.of<LibraryProvider>(context);

      _libraryProvider.getLibrary(libraryId: widget.libraryId).then((_) {
        _library = _libraryProvider.library;
        setState(() {
          _init = false;
          _loading = false;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
    final _libraryProvider = Provider.of<LibraryProvider>(context);

    _library = _libraryProvider.library;

    User _user = _userProvider.user;
    return _user.isLibrarian(_loading ? '' : _libraryProvider.librarian.id)
        ? DefaultTabController(
            length: 4,
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.add),
              ),
              appBar: AppBar(
                  title: Text(_loading ? '' : _library.name),
                  centerTitle: true,
                  bottom: TabBar(isScrollable: true, tabs: [
                    Text('Library Items'),
                    Text('Library Info'),
                    Text('Members'),
                    Text('Admin Panel'),
                  ])),
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
              appBar: AppBar(
                  title: Text(_loading ? '' : _library.name),
                  centerTitle: true,
                  bottom: TabBar(tabs: [
                    Text('Library Items'),
                    Text('Library Info'),
                  ])),
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
