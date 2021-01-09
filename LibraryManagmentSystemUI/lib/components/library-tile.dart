import 'package:LibraryManagmentSystem/components/library_image.dart';
import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/screens/library/library_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget libraryTile(
    {BuildContext context,
    LibrarySerializer library,
    @required bool joined,
    @required bool requested,
    bool icon,
    int index}) {
  return GridTile(
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LibraryScreen(
              libraryId: library.id,
            ),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4,
                    ),
                    child: FaIcon(
                        requested
                            ? FontAwesomeIcons.paperPlane
                            : joined
                                ? Icons.check
                                : Icons.check,
                        color: (requested || joined)
                            ? Colors.blue
                            : Colors.transparent),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: libraryImage(
                    image: library.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      library.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    ),
  );
}
