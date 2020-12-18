import 'package:flutter/material.dart';

import 'screen/sign-up.dart';

Drawer drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        ListTile(
          leading: Icon(
            Icons.person,
          ),
          title: Text('Sign up', style: Theme.of(context).textTheme.headline1),
          onTap: () => {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SignUp()))
          },
        ),
      ],
    ),
  );
}
