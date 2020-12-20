import 'dart:math' as math;

import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/config.dart';
import 'package:LibraryManagmentSystem/model/user.dart';
import 'package:LibraryManagmentSystem/provider/user-provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    print(_user.profilePhoto);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 16),
          Stack(
            children: [
              Center(
                child: Container(
                  child: CircleAvatar(
                    radius: 82,
                    child: CircleAvatar(
                        radius: 80,
                        child: ClipOval(
                            child: _user.profilePhoto != ''
                                ? Image.network(_user.profilePhoto)
                                : Image.asset('assets/images/user.png'))),
                  ),
                ),
              ),
              Positioned(
                bottom: 1,
                left: 50,
                child: Transform.rotate(
                  angle: math.pi,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _loading = true;
                      });
                      _userProvider.facebookLogout();
                    },
                    child: _loading
                        ? loading()
                        : CircleAvatar(
                            radius: 20,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: FaIcon(FontAwesomeIcons.signOutAlt),
                          ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 8),
          Center(child: Text(_user.username)),
        ],
      ),
    );
  }
}
