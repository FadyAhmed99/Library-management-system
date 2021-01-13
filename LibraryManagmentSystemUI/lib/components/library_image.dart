import 'package:flutter/cupertino.dart';

import '../constants.dart';

Widget libraryImage({String image, BoxFit fit}) {
  return  ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    child: FadeInImage(
      fit: fit,
      placeholder: kLibraryPlaceholder,
      image: NetworkImage(image ?? ''),
    ),
  );
}

Widget itemImage({String image, BoxFit fit}) {
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    child: FadeInImage(
      fit: fit,
      placeholder: kItemPlaceholder,
      image: NetworkImage(image ?? ''),
    ),
  );
}
