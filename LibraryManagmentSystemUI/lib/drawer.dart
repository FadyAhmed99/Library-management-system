import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:LibraryManagmentSystem/config.dart';

import 'package:LibraryManagmentSystem/screens/drawer/favourite_list_screen.dart';
import 'package:LibraryManagmentSystem/screens/drawer/subscribed_libraries.dart';
import 'package:LibraryManagmentSystem/screens/drawer/user_borrowing_list.dart';
import 'package:LibraryManagmentSystem/screens/drawer/users_logs_screen.dart';
import 'package:LibraryManagmentSystem/screens/library/library_screen.dart';
import 'package:LibraryManagmentSystem/screens/regestration/profile.dart';
import 'package:LibraryManagmentSystem/screens/regestration/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

Widget drawer(BuildContext context) {
  final user = Provider.of<User>(context).user;
  final _userProvider = Provider.of<User>(context);
  final _libraryProvider = Provider.of<Library>(context);

  return Theme(
    data: ThemeData(backgroundColor: Colors.white),
    child: Drawer(
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
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 10.0, bottom: 10.0),
                    child: user == null
                        ? Container()
                        : ClipOval(
                            child: CircleAvatar(
                              radius: 35,
                              child: FadeInImage(
                                fit: BoxFit.fill,
                                placeholder: kUserPlaceholder,
                                image: NetworkImage(user.profilePhoto ?? ''),
                              ),
                            ),
                          )),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                      user == null ? '' : user.firstname + ' ' + user.lastname,
                      style: Theme.of(context).textTheme.headline3),
                ),
              ],
            ),
          ),
          user != null
              ? user.librarian
                  ? Column(
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
                              return Profile(edit: false);
                            }));
                          },
                        ),
                        ListTile(
                          enabled: true,
                          leading: Icon(Icons.security),
                          title: Text('Admin Panel',
                              style: Theme.of(context).textTheme.headline2),
                          onTap: () {
                            if (!ModalRoute.of(context).isFirst) {
                              Navigator.pop(context);
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => LibraryScreen(
                                        libraryId: _libraryProvider.libraries
                                            .firstWhere((element) =>
                                                element.librarian == user.id)
                                            .id,
                                        page: 3)),
                              );
                            }
                          },
                        ),
                        ListTile(
                          enabled: true,
                          onTap: () async {
                            await _userProvider.logOut();
                            _userProvider.logOutFacebook().then((_) async {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => WelcomeScreen()),
                              );
                            });
                          },
                          leading: Icon(Icons.logout),
                          title: Text('Log out',
                              style: Theme.of(context).textTheme.headline2),
                        ),
                      ],
                    )
                  : Expanded(
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
                                  return Profile(edit: false);
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
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return UserSubscribedLibraries();
                                }),
                              );
                            },
                            enabled: true,
                            leading: Icon(Icons.subscriptions),
                            title: Text('Subscribed Libraries',
                                style: Theme.of(context).textTheme.headline2),
                          ),
                          ListTile(
                            enabled: true,
                            leading: Icon(Icons.assignment_turned_in),
                            title: Text('Borrowed Items',
                                style: Theme.of(context).textTheme.headline2),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return UserBorrowingList();
                              }));
                            },
                          ),
                          ListTile(
                              enabled: true,
                              leading: Icon(Icons.storage),
                              title: Text('User\'s Logs',
                                  style: Theme.of(context).textTheme.headline2),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return UsersLogsScreen();
                                }));
                              }),
                          ListTile(
                            enabled: true,
                            onTap: () async {
                              await _userProvider.logOut();
                              _userProvider.logOutFacebook().then((_) async {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => WelcomeScreen()),
                                );
                              });
                            },
                            leading: Icon(Icons.logout),
                            title: Text('Log out',
                                style: Theme.of(context).textTheme.headline2),
                          ),
                        ],
                      ),
                    )
              : Container(),
        ],
      ),
    ),
  );
}
