import 'package:LibraryManagmentSystem/components/library_image.dart';
import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:LibraryManagmentSystem/screens/item_details_screen.dart';
import 'package:LibraryManagmentSystem/screens/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BorrowedItemTile extends StatefulWidget {
  final TransactionSerializer transaction;
  final String libraryId;
  final String transactionId;
  BorrowedItemTile({this.transaction, this.libraryId, this.transactionId});
  @override
  _BorrowedItemTileState createState() => _BorrowedItemTileState();
}

class _BorrowedItemTileState extends State<BorrowedItemTile> {
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: InkWell(
        onTap: () {
          if (widget.transaction.item.itemLink != null &&
              widget.transaction.item.itemLink.toString().trim().length != 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ViewPDF(
                  fileLink: widget.transaction.item.itemLink,
                  title: widget.transaction.item.name
                ),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ItemInfoScreen(
                    itemId: widget.transaction.item.id,
                    libraryId: widget.transaction.borrowedFrom.id),
              ),
            );
          }
        },
        child: Card(
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: widget.transaction.item.isNew
                            ? FaIcon(
                                widget.transaction.item.isNew
                                    ? Icons.fiber_new
                                    : FontAwesomeIcons.heart,
                                color: Colors.red)
                            : null),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        widget.transaction.item.type == 'ebook'
                            ? Icons.picture_as_pdf
                            : null,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: itemImage(
                      image: widget.transaction.item.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      widget.transaction.item.name,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
