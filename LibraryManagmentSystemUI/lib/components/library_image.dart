import 'package:flutter/cupertino.dart';

import '../constants.dart';

Widget libraryImage({String image, BoxFit fit}) {
  return FadeInImage(
      fit: fit, placeholder: kLibraryPlaceholder, image: NetworkImage(image));
}
