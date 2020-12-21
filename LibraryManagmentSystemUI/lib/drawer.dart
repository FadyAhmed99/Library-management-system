
import 'package:LibraryManagmentSystem/screens/regestration/register.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        ListTile(
          leading: FaIcon(
            FontAwesomeIcons.user,
          ),
          title: Text('Profile', style: Theme.of(context).textTheme.headline1),
          onTap: () => {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return VerifyUser();
            }))
          },
        ),
      ],
    ),
  );
}
