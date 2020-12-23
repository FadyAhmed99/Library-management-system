import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/library-tile.dart';
import 'package:LibraryManagmentSystem/constants.dart';
import 'package:LibraryManagmentSystem/models/library.dart';
import 'package:LibraryManagmentSystem/models/user.dart';
import 'package:LibraryManagmentSystem/providers/library_provider.dart';
import 'package:LibraryManagmentSystem/providers/user-provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LibrariesRoomScreen extends StatefulWidget {
  @override
  _LibrariesRoomScreenState createState() => _LibrariesRoomScreenState();
}

class _LibrariesRoomScreenState extends State<LibrariesRoomScreen> {
  bool _loading = true;
  bool _init = true;

  List<Library> _lib;
  @override
  void didChangeDependencies() {
    if (_init) {
      final _libraryProvider = Provider.of<LibraryProvider>(context);
      _libraryProvider.getLibraries().then((_) {
        setState(() {
          _lib = _libraryProvider.libraries;
          _loading = false;
          _init = false;
        });
      });
      print(_lib);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _libraryProvider = Provider.of<LibraryProvider>(context);
    final _userProvider = Provider.of<UserProvider>(context);
    User _user = _userProvider.user;

    //_libraryProvider.getLibraries();
    _lib = _libraryProvider.libraries;
    return Scaffold(
      body: _loading
          ? loading()
          : Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.builder(
                  gridDelegate: kGridShape,
                  itemCount: _lib.length,
                  itemBuilder: (context, index) {
                    return libraryTile(
                        context: context,
                        library: _lib[index],
                        joined: _user.subscribedLibraries
                            .any((element) => element.id == _lib[index].id),
                        trueButton: 'joined',
                        falseButton: 'join',
                        onPressedFunction: () {},
                        icon: FontAwesomeIcons.check,
                        index: index);
                  }),
            ),
    );
  }
}
