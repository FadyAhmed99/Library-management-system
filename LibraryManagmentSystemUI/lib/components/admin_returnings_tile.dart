import 'package:LibraryManagmentSystem/components/three_cells_row.dart';
import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:LibraryManagmentSystem/components/trim_date.dart';
import 'package:flutter/material.dart';

import 'library_image.dart';

class ReturningTile extends StatefulWidget {
  final TransactionSerializer transaction;
  final bool borrowing;
  const ReturningTile({Key key, this.transaction, @required this.borrowing})
      : super(key: key);

  @override
  _ReturningTileState createState() => _ReturningTileState();
}

class _ReturningTileState extends State<ReturningTile> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
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
                  ListTile(
                    // leading: itemImage(
                    //     image: widget.transaction.item.available[0].image),
                    title: Table(
                      //  border: TableBorder.all(),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          itemImage(
                              image:
                                  widget.transaction.item.available[0].image),
                          Table(
                            children: [
                              TableRow(children: [
                                Text(
                                  'Member name',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ]),
                              TableRow(children: [
                                Text(
                                  widget.transaction.user.firstname +
                                      ' ' +
                                      widget.transaction.user.lastname,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                ),
                              ])
                            ],
                          ),
                        ]),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Table(
                    defaultColumnWidth: FixedColumnWidth(
                        (MediaQuery.of(context).size.width - 30) / 3),
                    children: [
                      threeRowsTitle(
                        context: context,
                        secondLabel: 'Returned To',
                        thirdLabel: widget.borrowing
                            ? 'Required Fees'
                            : requiredFees() == 'No Fees'
                                ? ''
                                : 'Required Fees',
                        firstLabel: '',
                      ),
                      threeRows(
                        secondLabel: widget.borrowing
                            ? widget.transaction.borrowedFrom.name
                            : widget.transaction.returnedTo == null
                                ? widget.transaction.borrowedFrom.name
                                : widget.transaction.returnedTo.name,
                        thirdLabel: widget.borrowing
                            ? "\$${widget.transaction.item.available[0].lateFees}/day"
                            : requiredFees() == 'No Fees'
                                ? ''
                                : "\$${widget.transaction.lateFees}",
                        firstLabel: '',
                      ),
                      threeEmptyRows(15)
                    ],
                  ),
                  Table(
                    defaultColumnWidth: FixedColumnWidth(
                        (MediaQuery.of(context).size.width - 30) / 3),
                    children: [
                      threeRowsTitle(
                        firstLabel: 'Item name',
                        secondLabel: widget.borrowing
                            ? 'Borrowing date'
                            : 'Returning date',
                        thirdLabel: widget.borrowing
                            ? 'Due date'
                            : requiredFees() == 'No Fees'
                                ? ''
                                : 'Payment status',
                        context: context,
                      ),
                      threeEmptyRows(10),
                      threeRows(
                        firstLabel: widget.transaction.item.name,
                        secondLabel: widget.borrowing
                            ? trimDate(widget.transaction.createdAt)
                            : trimDate(widget.transaction.returnDate),
                        thirdLabel: widget.borrowing
                            ? trimDate(widget.transaction.deadline)
                            : requiredFees() == 'No Fees'
                                ? ''
                                : requiredFees() == 'No Fees'
                                    ? 'No Fees'
                                    : widget.transaction.hasFees
                                        ? 'Required To Pay'
                                        : 'Paid',
                      ),
                      threeEmptyRows(20),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
