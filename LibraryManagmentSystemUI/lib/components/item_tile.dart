import 'package:LibraryManagmentSystem/model/item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemTile extends StatefulWidget {
  bool borrowed;
  bool favorite;
  Item item;
  ItemTile({this.borrowed, this.favorite, this.item});
  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    double height = 200;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {}),
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
                          child: FaIcon(FontAwesomeIcons.heart,
                              color:
                                  widget.borrowed ? Colors.red : Colors.grey)),
                    ],
                  ),
                  Hero(
                    tag: 1,
                    child: Container(
                      height: 90,
                      child: Image.network(
                        widget.item.toString(),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.item.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          height: height * 0.13,
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: RaisedButton(
            onPressed: () {},
            child: Text('da'),
            color: Theme.of(context).disabledColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
        ),
      ],
    );
  }
}
