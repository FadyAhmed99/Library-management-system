import 'package:LibraryManagmentSystem/screens/review_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TapToReview extends StatefulWidget {
  final String itemId;
  final String libraryId;
  final String itemName;
  final double rating;
  final bool refresh;
  final bool title;
  final double size;
  const TapToReview({
    Key key,
    @required this.itemId,
    @required this.libraryId,
    @required this.itemName,
    @required this.rating,
    @required this.refresh,
    @required this.title,
    @required this.size,
  }) : super(key: key);

  @override
  _TapToReviewState createState() => _TapToReviewState();
}

class _TapToReviewState extends State<TapToReview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size == 20
          ? (MediaQuery.of(context).size.width / 5)
          : null,
      child: Column(
        children: [
          widget.title ? SizedBox(height: 15) : Container(),
          widget.title
              ? Text(
                  'Rate item:',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                )
              : Text(''),
          InkWell(
            onTap: widget.title
                ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ReviewItemScreen(
                          refresh: widget.refresh,
                          itemId: widget.itemId,
                          itemName: widget.itemName,
                          libraryId: widget.libraryId,
                        ),
                      ),
                    );
                  }
                : null,
            child: RatingBarIndicator(
              itemBuilder: (context, index) {
                return Icon(
                  Icons.star,
                  color: Colors.blue,
                );
              },
              itemCount: 5,
              itemSize: widget.size,
              rating: widget.rating??0,
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
