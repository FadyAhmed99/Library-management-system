import 'package:LibraryManagmentSystem/components/library-tile.dart';
import 'package:LibraryManagmentSystem/provider/user-provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Libraries extends StatefulWidget {
  @override
  _LibrariesState createState() => _LibrariesState();
}

class _LibrariesState extends State<Libraries> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: MediaQuery.of(context).size.width /500,),
            itemCount: 5,
            itemBuilder: (context, index) {
              return libraryTile(
                  context: context,
                  title: ' الحديثة اسم المكتبة الالكترونية',
                  joined: index == 1 ? false : true,
                  image:
                      'https://msa.edu.eg/msauniversity/images/content/msa-university-library-new.jpg',
                  trueButton: 'joined',
                  falseButton: 'join',
                  onPressedFunction: () {
                    print('sad');
                  },
                  icon: FontAwesomeIcons.check,
                  index: index);
            }),
      ),
    );
  }
}
