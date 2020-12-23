import 'package:LibraryManagmentSystem/components/library_image.dart';
import 'package:LibraryManagmentSystem/models/library.dart';
import 'package:LibraryManagmentSystem/screens/library/library_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget libraryTile(
    {BuildContext context,
    Library library,
    bool joined,
    String trueButton,
    String falseButton,
    Function onPressedFunction,
    IconData icon,
    int index}) {
  double height = 200;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisSize: MainAxisSize.min,
    children: [
      InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LibraryScreen(
                library: library,
              ),
            ),
          );
        },
        child: Container(
          height: height * 0.87,
          child: Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: FaIcon(icon,
                            color: joined ? Colors.blue : Colors.transparent)),
                  ],
                ),
                Hero(
                  tag: library.id,
                  child: Container(
                    height: 90,
                    child: libraryImage(image: library.image, fit: BoxFit.fill),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    library.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 5.0,),
      Container(
        height: height * 0.13,
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: RaisedButton(
          onPressed: onPressedFunction,
          child: Text(joined ? trueButton : falseButton),
          color: joined ? Theme.of(context).disabledColor : null,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
      ),
    ],
  );
}
