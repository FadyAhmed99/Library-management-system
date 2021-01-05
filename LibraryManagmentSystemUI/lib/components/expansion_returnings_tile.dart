import 'package:LibraryManagmentSystem/components/small_button.dart';
import 'package:LibraryManagmentSystem/components/three_cells_row.dart';
import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:flutter/material.dart';

import 'library_image.dart';

class ReturningsExpansionTile extends StatefulWidget {
  final TransactionSerializer transaction;

  const ReturningsExpansionTile({Key key, this.transaction}) : super(key: key);

  @override
  _ReturningsExpansionTileState createState() =>
      _ReturningsExpansionTileState();
}

class _ReturningsExpansionTileState extends State<ReturningsExpansionTile> {
  bool _showDetails = false;
  @override
  Widget build(BuildContext context) {
    String trimDate(DateTime date) {
      return date.toString().split(' ')[0].replaceAll('-', '/');
    }

    String requiredFees() {
      int diff = widget.transaction.deadline.difference(DateTime.now()).inDays;
      return diff < 0
          ? '\$${diff.abs() * widget.transaction.lateFees / 100}'
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
                      Container(
                        width: (MediaQuery.of(context).size.width / 5),
                        child: itemImage(
                          image: widget.transaction.item.available[0].image,
                        ),
                      ),
                      Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.top,
                        defaultColumnWidth: FixedColumnWidth(
                            MediaQuery.of(context).size.width / 4.5),
                        children: [
                          threeChecks(
                            true,
                            widget.transaction.returned,
                            widget.transaction.hasFees,
                            context: context,
                          ),
                          threeEmptyRows(5),
                          threeRowsTitle(
                            context: context,
                            firstLabel: 'Requested To Return',
                            secondLabel: "Returned",
                            thirdLabel:
                                requiredFees() == 'No Fees' ? '' : "Fees Paid",
                          ),
                          threeEmptyRows(10),
                        ],
                      ),
                    ],
                  ),
                  Table(
                    defaultColumnWidth: FixedColumnWidth(
                        (MediaQuery.of(context).size.width - 30) / 3),
                    children: [
                      threeRowsTitle(
                          context: context,
                          firstLabel: 'Item name',
                          secondLabel: 'Borrowing Date',
                          thirdLabel: 'Returning Date'),
                      threeEmptyRows(10),
                      threeRows(
                        firstLabel: widget.transaction.item.name,
                        secondLabel: trimDate(widget.transaction.createdAt),
                        thirdLabel: widget.transaction.returned
                            ? trimDate(widget.transaction.returnDate)
                            : '',
                      ),
                      threeEmptyRows(10),
                    ],
                  ),
                  _showDetails
                      ? Table(
                          defaultColumnWidth: FixedColumnWidth(
                              (MediaQuery.of(context).size.width - 30) / 3),
                          children: [
                            threeRowsTitle(
                                context: context,
                                firstLabel: 'Returned to',
                                secondLabel: 'Fees',
                                thirdLabel: 'Required Fees'),
                            threeEmptyRows(10),
                            threeRows(
                              firstLabel: widget.transaction.returnedTo != null
                                  ? widget.transaction.returnedTo.name
                                  : widget.transaction.borrowedFrom.name,
                              secondLabel:
                                  "\$${(widget.transaction.lateFees / 100)}/ day",
                              thirdLabel: requiredFees(),
                            ),
                            threeEmptyRows(10),
                          ],
                        )
                      : Container(),
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
                    child: Text('Show Detailes'),
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
    Text(firstLabel, textAlign: TextAlign.center),
    Text(secondLabel, textAlign: TextAlign.center),
    Text(thirdLabel, textAlign: TextAlign.center),
  ]);
}

TableRow _emptyRow(double space) {
  return TableRow(children: [
    Container(height: space),
    Container(height: space),
    Container(height: space),
  ]);
}
