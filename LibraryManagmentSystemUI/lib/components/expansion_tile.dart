import 'package:LibraryManagmentSystem/components/small_button.dart';
import 'package:LibraryManagmentSystem/components/tap_to_review.dart';
import 'package:LibraryManagmentSystem/components/three_cells_row.dart';
import 'package:LibraryManagmentSystem/classes/borrow_request.dart';
import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'library_image.dart';

class CustomExpantionTile extends StatefulWidget {
  final TransactionSerializer transaction;
  final BorrowRequestSerializer borrowRequest;
  const CustomExpantionTile({Key key, this.transaction, this.borrowRequest})
      : super(key: key);

  @override
  _CustomExpantionTileState createState() => _CustomExpantionTileState();
}

class _CustomExpantionTileState extends State<CustomExpantionTile> {
  bool _showDetails = false;
  @override
  Widget build(BuildContext context) {
    Widget _stars(double size) {
      return widget.transaction == null
          ? Container()
          : widget.transaction.item.reviews[0].rating == null
              ? TapToReview(
                  size: size,
                  title: true,
                  refresh: false,
                  rating: widget.transaction.item.reviews[0].rating,
                  itemId: widget.transaction.item.id,
                  itemName: widget.transaction.item.name,
                  libraryId: widget.transaction.borrowedFrom.id,
                )
              : TapToReview(
                  size: size,
                  title: false,
                  refresh: false,
                  rating: widget.transaction.item.reviews[0].rating,
                  itemId: widget.transaction.item.id,
                  itemName: widget.transaction.item.name,
                  libraryId: widget.transaction.borrowedFrom.id,
                );
    }

    String trimDate(DateTime date) {
      if (date == null) return '';
      return date.toString().split(' ')[0].replaceAll('-', '/');
    }

    String requiredFees() {
      int diff = widget.transaction.deadline.difference(DateTime.now()).inDays;
      return diff < 0
          ? '\$${diff.abs() * widget.transaction.lateFees}'
          : 'No Fees';
    }

    return InkWell(
      onTap: () {
        setState(() {
          _showDetails = !_showDetails;
        });
      },
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(8),
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              margin: EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: (MediaQuery.of(context).size.width / 4),
                            child: itemImage(
                                image: widget.transaction == null
                                    ? widget
                                        .borrowRequest.item.available[0].image
                                    : widget
                                        .transaction.item.available[0].image),
                          ),
                          _showDetails ? Container() : _stars(20)
                        ],
                      ),
                      Table(
                        // border: TableBorder.all(),
                        defaultColumnWidth: FixedColumnWidth(
                            MediaQuery.of(context).size.width / 5),
                        children: [
                          TableRow(children: [
                            Icon(
                              Icons.check,
                              color: Colors.blue,
                            ),
                            widget.borrowRequest == null
                                ? Icon(
                                    Icons.check,
                                    color: Colors.blue,
                                  )
                                : Container(),
                            widget.borrowRequest != null
                                ? Container()
                                : !widget.transaction.requestedToReturn
                                    ? Container()
                                    : Icon(
                                        Icons.check,
                                        color: Colors.blue,
                                      ),
                          ]),
                          _emptyRow(5),
                          threeRowsTitle(
                            firstLabel: 'Requested',
                            secondLabel: "Borrowed",
                            thirdLabel: "Return Request",
                            context: context,
                          ),
                          _emptyRow(10),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Table(
                    defaultColumnWidth: FixedColumnWidth(
                        (MediaQuery.of(context).size.width - 30) / 3),
                    children: [
                      threeRowsTitle(
                          context: context,
                          firstLabel: 'Item name',
                          secondLabel: 'Borrowing Date',
                          thirdLabel: 'Due Date'),
                      threeEmptyRows(5),
                      threeRows(
                          firstLabel: widget.borrowRequest == null
                              ? widget.transaction.item.name
                              : widget.borrowRequest.item.name,
                          secondLabel: trimDate(
                            widget.borrowRequest == null
                                ? widget.transaction.createdAt
                                : DateTime.parse(widget.borrowRequest.deadline)
                                    .subtract(
                                    Duration(days: 2),
                                  ),
                          ),
                          thirdLabel: widget.borrowRequest != null
                              ? trimDate(
                                  DateTime.parse(widget.borrowRequest.deadline))
                              : trimDate(widget.transaction.deadline)),
                      threeEmptyRows(20),
                    ],
                  ),
                  _showDetails
                      ? Table(
                          defaultColumnWidth: FixedColumnWidth(
                              (MediaQuery.of(context).size.width - 30) / 3),
                          children: [
                            threeRowsTitle(
                                context: context,
                                firstLabel: 'Borrowed from',
                                secondLabel: 'Fees',
                                thirdLabel: 'Required Fees'),
                            threeEmptyRows(5),
                            threeRows(
                                firstLabel: widget.borrowRequest == null
                                    ? widget.transaction.borrowedFrom.name
                                    : widget.borrowRequest.library.name,
                                secondLabel: widget.borrowRequest == null
                                    ? "\$${(widget.transaction.lateFees)}/day"
                                    : "\$${(widget.borrowRequest.item.available[0].lateFees)}/day",
                                thirdLabel: widget.borrowRequest == null
                                    ? requiredFees()
                                    : ''),
                            threeEmptyRows(10),
                          ],
                        )
                      : Container(),
                  _showDetails ? _stars(30) : Container()
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SmallButton(
                    child: Text('Show details'),
                    onPressed: () {
                      setState(() {
                        _showDetails = !_showDetails;
                      });
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}

TableRow _row(String firstLabel, String secondLabel, String thirdLabel) {
  return TableRow(children: [
    Text(firstLabel ?? '', textAlign: TextAlign.center),
    Text(secondLabel ?? '', textAlign: TextAlign.center),
    Text(thirdLabel ?? '', textAlign: TextAlign.center),
  ]);
}

TableRow _emptyRow(double space) {
  return TableRow(children: [
    Container(height: space),
    Container(height: space),
    Container(height: space),
  ]);
}
