import 'package:LibraryManagmentSystem/components/library-tile.dart';
import 'package:LibraryManagmentSystem/model/library.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'regestration/library_screen.dart';

class LibrariesRoomScreen extends StatefulWidget {
  @override
  _LibrariesRoomScreenState createState() => _LibrariesRoomScreenState();
}

class _LibrariesRoomScreenState extends State<LibrariesRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 230, childAspectRatio: 0.75),
            itemCount: 5,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LibraryScreen(
                        library: Library(name: "das"),
                      ),
                    ),
                  );
                },
                child: libraryTile(
                    context: context,
                    title: 'Library Name',
                    joined: index == 1 ? false : true,
                    image:
                        'https://msa.edu.eg/msauniversity/images/content/msa-university-library-new.jpg',
                    trueButton: 'joined',
                    falseButton: 'join',
                    onPressedFunction: () {},
                    icon: FontAwesomeIcons.check,
                    index: index),
              );
            }),
      ),
    );
  }
}
