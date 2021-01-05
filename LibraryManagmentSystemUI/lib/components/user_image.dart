import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

Widget userImage({String image}) {
  return ClipOval(
    child: CircleAvatar(
      child: FadeInImage(
        fit: BoxFit.fill,
        placeholder: kUserPlaceholder,
        image: NetworkImage(image ?? ''),
      ),
    ),
  );
}
