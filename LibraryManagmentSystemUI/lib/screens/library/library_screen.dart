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
  final Library library;
  LibraryScreen({this.library});
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
    final _libraryProvider =
        Provider.of<LibraryProvider>(context, listen: false);
    User _user = _userProvider.user;
    print(_user.librarian);
    return _user.librarian
        ? DefaultTabController(
            length: 4,
            child: Scaffold(
                appBar: AppBar(
                    title: Text(widget.library.name),
                    centerTitle: true,
                    bottom: TabBar(isScrollable: true, tabs: [
                      Text('Library Items'),
                      Text('Library Info'),
                      Text('Members'),
                      Text('Admin Panel'),
                    ])),
                body: TabBarView(children: [
                  LibraryItemsScreen(),
                  LibraryInfoScreen(library: widget.library),
                  LibraryMembersScreen(
                    borrowBtn: true,
                    removeBtn: true,
                    reviewBtn: true,
                    libraryId: widget.library.id,
                    fn: _libraryProvider.getLibraryMembers(
                        libraryId: widget.library.id),
                  ),
                  LibraryAdminPanelScreen(widget.library.id)
                ])))
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                  title: Text(widget.library.name),
                  centerTitle: true,
                  bottom: TabBar(tabs: [
                    Text('Library Items'),
                    Text('Library Info'),
                  ])),
              body: TabBarView(children: [
                LibraryItemsScreen(),
                LibraryInfoScreen(library: widget.library),
              ]),
            ));
  }
}
