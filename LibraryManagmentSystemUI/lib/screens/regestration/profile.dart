import 'dart:math' as math;

import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/models/user.dart';
import 'package:LibraryManagmentSystem/providers/user-provider.dart';
import 'package:LibraryManagmentSystem/screens/regestration/register.dart';
import 'package:LibraryManagmentSystem/screens/regestration/signin.dart';
import 'package:LibraryManagmentSystem/screens/regestration/signup.dart';
import 'package:LibraryManagmentSystem/screens/regestration/welcome_screen.dart';
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
                            child: userImage(image: _user.profilePhoto))),
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
                      _userProvider.facebookLogout().then((_) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => SignIn()),
                            (Route<dynamic> route) => false);
                      });
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
