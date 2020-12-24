import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/providers/user-provider.dart';
import 'package:LibraryManagmentSystem/screens/drawer/favourite_list_screen.dart';
import 'package:LibraryManagmentSystem/screens/regestration/profile.dart';
import 'package:LibraryManagmentSystem/screens/regestration/register.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

Widget drawer(BuildContext context) {
  final user = Provider.of<UserProvider>(context).user;
  return Drawer(
    child: Column(
      children: [
        Container(
          height: 150.0,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, left: 10.0, bottom: 10.0),
                child: CircleAvatar(
                  child: ClipOval(
                      child: user == null
                          ? Container()
                          : userImage(
                              image: user.profilePhoto,
                            )),
                  radius: 35,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(user == null ? '' : user.username,
                    style: Theme.of(context).textTheme.headline3),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.user,
                  ),
                  title: Text('Profile',
                      style: Theme.of(context).textTheme.headline2),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Profile();
                    }));
                  }),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return FavouriteListScreen();
                  }));
                },
                leading: FaIcon(
                  FontAwesomeIcons.heart,
                ),
                title: Text('Favourite List',
                    style: Theme.of(context).textTheme.headline2),
              ),
              ListTile(
                enabled: false,
                leading: Icon(Icons.subscriptions),
                title: Text('Subscribed Libraries',
                    style: Theme.of(context).textTheme.headline2),
              ),
              ListTile(
                enabled: false,
                leading: Icon(Icons.assignment_turned_in),
                title: Text('Borrowed Items',
                    style: Theme.of(context).textTheme.headline2),
              ),
              ListTile(
                enabled: false,
                leading: Icon(Icons.storage),
                title: Text('User\'s Logs',
                    style: Theme.of(context).textTheme.headline2),
              ),
              ListTile(
                enabled: false,
                leading: Icon(Icons.security),
                title: Text('Admin Panel',
                    style: Theme.of(context).textTheme.headline2),
              ),
              ListTile(
                enabled: false,
                leading: Icon(Icons.logout),
                title: Text('Log out',
                    style: Theme.of(context).textTheme.headline2),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
