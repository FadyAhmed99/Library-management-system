import 'package:LibraryManagmentSystem/screen/profile.dart';
import 'package:flutter/material.dart';

import 'screen/sign-up.dart';

Widget drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        ListTile(
          leading: Icon(
            Icons.person,
          ),
          title: Text('Sign up', style: Theme.of(context).textTheme.headline1),
          onTap: () => {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return SignUp();
            }))
          },
        ),
        ListTile(
          leading: Icon(
            Icons.picture_as_pdf,
          ),
          title: Text('Profile', style: Theme.of(context).textTheme.headline1),
          onTap: () => {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Profile();
            }))
          },
        ),
      ],
    ),
  );
}
