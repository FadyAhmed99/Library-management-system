import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/providers/user-provider.dart';
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
                padding: const EdgeInsets.all(10.0),
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
                    style: Theme.of(context).textTheme.headline2),
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
                    style: Theme.of(context).textTheme.headline1),
                onTap: () => {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return VerifyUser();
                  }))
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
