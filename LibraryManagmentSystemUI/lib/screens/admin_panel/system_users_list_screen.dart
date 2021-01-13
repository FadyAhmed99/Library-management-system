import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SystemUsersList extends StatefulWidget {
  @override
  _SystemUsersListState createState() => _SystemUsersListState();
}

class _SystemUsersListState extends State<SystemUsersList> {
  bool _init = true;
  bool _loading = true;
  List<UserSerializer> _users = [];
  @override
  void didChangeDependencies() {
    if (_init) {
      final _userProvider = Provider.of<User>(context);
      _userProvider.getSystemUsersList().then((users) {
        setState(() {
          _users = users;
          _loading = false;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          backTheme: true, title: 'System\'s Users List', context: context),
      body: _loading
          ? loading()
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(16.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8),
                    tileColor: Theme.of(context).cardColor,
                    leading: userImage(image: _users[index].profilePhoto),
                    title: Center(
                        child: Text(_users[index].firstname +
                            ' ' +
                            _users[index].lastname)),
                  ),
                );
              }),
    );
  }
}
