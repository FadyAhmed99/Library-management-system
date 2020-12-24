import 'package:flutter/cupertino.dart';

import '../constants.dart';

Widget userImage({String image}) {
  return FadeInImage(
    fit: BoxFit.cover,
    placeholder: kUserPlaceholder,
    image: NetworkImage(image ?? ''),
  );
}
