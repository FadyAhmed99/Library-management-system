import 'package:LibraryManagmentSystem/model/user.dart';
import 'package:LibraryManagmentSystem/provider/user-provider.dart';
import 'package:LibraryManagmentSystem/screen/regestration/profile.dart';
import 'package:LibraryManagmentSystem/screen/regestration/signin.dart';
import 'package:LibraryManagmentSystem/screen/regestration/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyUser extends StatefulWidget {
  @override
  _VerifyUserState createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  bool _loading = false;
  void loadPage() {
    setState(() {
      _loading = !_loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
    User _user = _userProvider.user;
    print(_user);
    return _user == null
        ? DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  title: Text('Regestration'),
                  bottom: TabBar(
                    tabs: [
                      Tab(text: 'Login'),
                      Tab(text: 'Signup'),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [SignIn(), SignUp()],
                )),
          )
        : Profile();
  }
}
