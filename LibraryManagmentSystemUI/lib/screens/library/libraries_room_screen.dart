import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/library-tile.dart';
import 'package:LibraryManagmentSystem/constants.dart';
import 'package:LibraryManagmentSystem/drawer.dart';
import 'package:LibraryManagmentSystem/models/library.dart';
import 'package:LibraryManagmentSystem/providers/library_provider.dart';
import 'package:LibraryManagmentSystem/providers/user-provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      final _userProdided = Provider.of<UserProvider>(context);
      _userProdided.getUserProfile().then((value) {
        _libraryProvider.getLibraries().then((_) {
          setState(() {
            _lib = _libraryProvider.libraries;
            _loading = false;
            _init = false;
          });
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return ourDialog(
            context: context,
            error: 'Are You Sure Exit?',
            button2: FlatButton(
                child: Text('Exit'),
                onPressed: () => SystemChannels.platform
                    .invokeMethod('SystemNavigator.pop')));
      },
      child: Scaffold(
        drawer: drawer(context),
        appBar: AppBar(title: Text('Libraries Room'), centerTitle: true),
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
                          joined: index == 1 ? false : true,
                          trueButton: 'joined',
                          falseButton: 'join',
                          onPressedFunction: () {},
                          icon: FontAwesomeIcons.check,
                          index: index);
                    }),
              ),
      ),
    );
  }
}
