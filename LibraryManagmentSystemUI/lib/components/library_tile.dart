import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget libraryTile(
    {BuildContext context,
    String title,
    String image,
    bool joined,
    String trueButton,
    String falseButton,
    Function onPressedFunction,
    IconData icon,
    int index}) {
  Size size = MediaQuery.of(context).size;
  print(size.aspectRatio);
  double height = 200;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
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
                tag: index,
                child: Container(
                  height: 90,
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
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

// Column(children: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             //FaIcon(FontAwesomeIcons.checkCircle)
//           ],
//         ),
//       ),
//       Hero(
//           tag: '1',
//           child: Container(
//             height: 100,
//             child: Image.network(
//               image,
//             ),
//           )),
//       Expanded(
//         child: Padding(
//           padding: const EdgeInsets.only(right: 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               RaisedButton(
//                 onPressed: () {},
//                 child: Text(joined ? 'joined' : 'join'),
//                 color: joined ? Theme.of(context).disabledColor : null,
//               )
//             ],
//           ),
//         ),
//       ),
//     ]),
