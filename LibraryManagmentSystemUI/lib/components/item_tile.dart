import 'package:LibraryManagmentSystem/components/library_image.dart';
import 'package:LibraryManagmentSystem/models/item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ItemTile extends StatefulWidget {
  bool borrowed;
  bool favorite;
  Item item;
  ItemTile({this.borrowed = false, this.favorite = false, this.item});
  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  bool favorite;
  bool borrowed;
  @override
  void initState() {
    favorite = widget.favorite;
    borrowed = widget.borrowed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = 220;
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
            height: height * 0.9,
            child: Card(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: widget.item.isNew
                                ? FaIcon(
                                    widget.item.isNew
                                        ? Icons.new_releases_rounded
                                        : FontAwesomeIcons.heart,
                                    color: Colors.red)
                                : null),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                favorite = !favorite;
                              });
                            },
                            child: FaIcon(
                                favorite
                                    ? FontAwesomeIcons.solidHeart
                                    : FontAwesomeIcons.heart,
                                color: favorite ? Colors.red : Colors.grey),
                          )),
                    ],
                  ),
                  Hero(
                    tag: 1,
                    child: Container(
                      height: height * 0.4,
                      child: libraryImage(
                        image: widget.item.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        RatingBarIndicator(
                          itemBuilder: (context, index) {
                            return Icon(
                              Icons.star,
                              color: Colors.blue,
                            );
                          },
                          itemCount: 5,
                          itemSize: 20,
                          rating: 3.5,
                        ),
                        Text(
                          widget.item.name + 'dsada sjaskd naskjd naskj db',
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: widget.item.amount != 0
                                  ? Text('Available',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(
                                              color: Colors.blueAccent,
                                              fontSize: 12))
                                  : Text(
                                      'Not Available',
                                      textAlign: TextAlign.end,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(fontSize: 12),
                                    ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          height: height * 0.2,
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: RaisedButton(
            onPressed: () {},
            child: Text(
              borrowed ? "Borrowed" : "Request Borrowing",
              maxLines: 1,
              style: TextStyle(fontSize: 12),
            ),
            color: Theme.of(context).disabledColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
        ),
      ],
    );
  }
}
