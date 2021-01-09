import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/library-tile.dart';
import 'package:LibraryManagmentSystem/constants.dart';
import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserSubscribedLibraries extends StatefulWidget {
  @override
  _UserSubscribedLibrariesState createState() =>
      _UserSubscribedLibrariesState();
}

class _UserSubscribedLibrariesState extends State<UserSubscribedLibraries> {
  bool _init = true;

  List<LibrarySerializer> _libs = [];
  @override
  void didChangeDependencies() {
    if (_init) {
      final _subsProvider = Provider.of<User>(context);

      _subsProvider.getSubscribedLibraries().then((_) {
        setState(() {
          _libs = _subsProvider.subs;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _subsProvider = Provider.of<User>(context);

    return Scaffold(
      appBar: appBar(
          title: 'Subscribed Libraries', backTheme: true, context: context),
      body: RefreshIndicator(
        onRefresh: () async {
          await _subsProvider.getSubscribedLibraries();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              itemCount: _libs.length,
              gridDelegate: kGridShape(context: context),
              itemBuilder: (context, index) {
                return libraryTile(
                  context: context,
                  icon: true,
                  library: _libs[index],
                  joined: _libs[index].status=='member' ,
                  requested: _libs[index].status=='pending'
                );
              }),
        ),
      ),
    );
  }
}
