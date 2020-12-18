import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/model/user.dart';
import 'package:LibraryManagmentSystem/provider/user-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
    User _user = _userProvider.user;

    return Scaffold(
      body: _user != null
          ? ListView(
              children: [
                Text(_user.username),
                _loading
                    ? loading()
                    : RaisedButton(
                        onPressed: () {
                          setState(() {
                            _loading = true;
                          });
                          _userProvider.logoutUser(_user.token);
                          Navigator.pop(context);
                        },
                        child: Text('Log out'),
                      )
              ],
            )
          : Text(''),
    );
  }
}
