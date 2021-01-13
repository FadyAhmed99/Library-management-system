import 'package:LibraryManagmentSystem/classes/favorite.dart';
import 'package:LibraryManagmentSystem/classes/item.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:LibraryManagmentSystem/components/library_image.dart';
import 'package:LibraryManagmentSystem/screens/item_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatefulWidget {
  bool borrowed;
  bool favorite;
  ItemSerializer item;
  String libraryId;
  bool stars;
  ItemTile({
    this.borrowed = false,
    this.favorite = false,
    this.item,
    this.stars = true,
    @required this.libraryId,
  });
  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<User>(context);
    final _favProvider = Provider.of<Favorite>(context);
    return GridTile(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ItemInfoScreen(
                libraryId: widget.libraryId,
                itemId: widget.item.id,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4,
                          ),
                          child: widget.item.isNew
                              ? FaIcon(
                                  widget.item.isNew
                                      ? Icons.fiber_new
                                      : FontAwesomeIcons.heart,
                                  color: Colors.red)
                              : null),
                      _userProvider.user.librarian
                          ? Container()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: InkWell(
                                onTap: !widget.favorite
                                    ? () {
                                        _favProvider
                                            .addToFavourites(
                                                itemId: widget.item.id,
                                                libraryId: widget.libraryId)
                                            .then((value) {
                                          if (value == null)
                                            _favProvider.getFavourites();
                                        });
                                      }
                                    : () {
                                        _favProvider
                                            .deleteFromFavourites(
                                                libraryId: widget.libraryId,
                                                itemId: widget.item.id)
                                            .then((value) {
                                          if (value == null)
                                            setState(() {
                                              widget.favorite =
                                                  !widget.favorite;
                                            });
                                        });
                                      },
                                child: FaIcon(
                                    widget.favorite
                                        ? FontAwesomeIcons.solidHeart
                                        : FontAwesomeIcons.heart,
                                    color: widget.favorite
                                        ? Colors.red
                                        : Colors.grey),
                              ),
                            ),
                    ]),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: itemImage(
                      image: widget.item.image,
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
                      widget.stars
                          ? RatingBarIndicator(
                              itemBuilder: (context, index) {
                                return Icon(
                                  Icons.star,
                                  color: Colors.blue,
                                );
                              },
                              itemCount: 5,
                              itemSize: 20,
                              rating: double.parse(
                                          "${widget.item.averageRating}",
                                          (e) => null) ==
                                      null
                                  ? 0.0
                                  : double.parse("${widget.item.averageRating}",
                                      (e) => null),
                            )
                          : Container(),
                      Text(
                        widget.item.name,
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
                                        .copyWith(fontSize: 12)
                                        .copyWith(color: Colors.red),
                                  ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
