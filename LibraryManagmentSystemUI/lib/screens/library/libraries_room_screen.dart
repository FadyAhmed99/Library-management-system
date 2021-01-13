import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/library-tile.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/components/small_button.dart';
import 'package:LibraryManagmentSystem/constants.dart';
import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../drawer.dart';

class LibrariesRoomScreen extends StatefulWidget {
  @override
  _LibrariesRoomScreenState createState() => _LibrariesRoomScreenState();
}

class _LibrariesRoomScreenState extends State<LibrariesRoomScreen> {
  bool _loading = true;
  bool _init = true;

  List<LibrarySerializer> _lib = [];
  List<LibrarySerializer> _subs = [];
  @override
  void didChangeDependencies() async {
    if (_init) {
      final _subsLibrariesProvider = Provider.of<User>(context);
      final _libraryProvider = Provider.of<Library>(context);
      await _subsLibrariesProvider.getSubscribedLibraries();
      _libraryProvider.getLibrary().then((value) {
        if (value != null) {
          ourDialog(error: value, context: context);
        } else {
          setState(() {
            _subs = _subsLibrariesProvider.subs;
            _lib = _libraryProvider.libraries;
            _loading = false;
            _init = false;
          });
        }
      });

      _init = false;
    }
    super.didChangeDependencies();
  }

  String joined = '';
  @override
  Widget build(BuildContext context) {
    final _libraryProvider = Provider.of<Library>(context);
    final _userProvider = Provider.of<User>(context);
    final _user = Provider.of<User>(context).user;
    final _subsLibrariesProvider = Provider.of<User>(context);
    _subs = _subsLibrariesProvider.subs;


    return WillPopScope(
      onWillPop: () async {
        return ourDialog(
            context: context,
            error: 'Do you want to exit?',
            btn1: 'No',
            button2: FlatButton(
                child: Text('Exit'),
                onPressed: () => SystemChannels.platform
                    .invokeMethod('SystemNavigator.pop')));
      },
      child: Scaffold(
        drawer: drawer(context),
        appBar:
            appBar(title: 'Libraries Room', backTheme: true, context: context),
        body: _loading
            ? loading()
            : RefreshIndicator(
                onRefresh: () async {
                  await _libraryProvider.getLibrary();
                  await _userProvider.getSubscribedLibraries();
                  _lib = _libraryProvider.libraries;
                  _subs = _subsLibrariesProvider.subs;
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GridView.builder(
                      gridDelegate: kGridShape(context: context),
                      itemCount: _lib.length,
                      itemBuilder: (context, index) {
                        joined = _subs
                                    .where((sub) =>
                                        sub.status == 'member' &&
                                        sub.id == _lib[index].id)
                                    .toList()
                                    .length !=
                                0
                            ? 'Joined'
                            : _subs
                                        .where((sub) =>
                                            sub.status == 'pending' &&
                                            sub.id == _lib[index].id)
                                        .toList()
                                        .length !=
                                    0
                                ? 'Request Sent'
                                : "Join";

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Center(
                                  child: libraryTile(
                                    context: context,
                                    library: _lib[index],
                                    joined: joined == 'Joined',
                                    requested: joined == 'Request Sent',
                                    icon: !_userProvider.user.librarian,
                                    index: index,
                                  ),
                                ),
                              ),
                              _user.librarian
                                  ? Container()
                                  : Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      child: RoundedButton(
                                        onPressed: (joined == 'Joined' ||
                                                joined == 'Request Sent')
                                            ? null
                                            : () async {
                                                await _userProvider
                                                    .sendJoinRequest(
                                                        libraryId:
                                                            _lib[index].id)
                                                    .then((err) async {
                                                  if (err == null) {
                                                    await _subsLibrariesProvider
                                                        .getSubscribedLibraries();
                                                  }
                                                });
                                              },
                                        title: joined,
                                      ),
                                    ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
      ),
    );
  }
}
