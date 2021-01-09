import 'package:LibraryManagmentSystem/components/small_button.dart';
import 'package:LibraryManagmentSystem/components/three_cells_row.dart';
import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/classes/fee.dart';
import 'package:LibraryManagmentSystem/screens/pay_fee_screen.dart';
import 'package:flutter/material.dart';

import 'library_image.dart';

class FeeTile extends StatefulWidget {
  final FeeSerializer fee;
  final bool admin;
  const FeeTile({Key key, this.fee, this.admin}) : super(key: key);

  @override
  _FeeTileState createState() => _FeeTileState();
}

class _FeeTileState extends State<FeeTile> {
  @override
  Widget build(BuildContext context) {
    String trimDate(DateTime date) {
      return date == null
          ? ''
          : date.toString().split(' ')[0].replaceAll('-', '/');
    }

    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(8),
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Container(
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 5),
                    Container(
                      height: 70,
                      width: 70,
                      child: widget.admin
                          ? userImage(image: widget.fee.user.profilePhoto)
                          : itemImage(
                              image: widget.fee.item.available[0].image),
                    ),
                    Expanded(
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        // border: TableBorder.all(),
                        children: [
                          !widget.admin
                              ? TableRow(children: [Container()])
                              : TableRow(children: [
                                  Text(
                                    "Member name",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(color: Colors.grey),
                                  ),
                                ]),
                          !widget.admin
                              ? TableRow(children: [Container()])
                              : TableRow(children: [
                                  Text(
                                    widget.fee.user.firstname +
                                        ' ' +
                                        widget.fee.user.lastname,
                                    textAlign: TextAlign.center,
                                  ),
                                ]),
                          TableRow(children: [SizedBox(height: 15)]),
                          TableRow(children: [
                            widget.admin
                                ? Text(
                                    'Required Fees',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(color: Colors.grey),
                                  )
                                : Container()
                          ]),
                          TableRow(children: [
                            widget.admin
                                ? Text(
                                    "\$${widget.fee.fees}",
                                    textAlign: TextAlign.center,
                                  )
                                : Container(),
                          ]),
                        ],
                      ),
                    )
                  ],
                ),
                Table(
                  defaultColumnWidth: FixedColumnWidth(
                      (MediaQuery.of(context).size.width - 30) / 3),
                  children: [
                    threeEmptyRows(20),
                    threeRowsTitle(
                        firstLabel: widget.admin
                            ? 'Item name'
                            : widget.fee.paid
                                ? 'Payment Date'
                                : 'Item name',
                        secondLabel: widget.admin ? 'Payment Date' : 'Status',
                        thirdLabel: widget.admin ? 'Payment Status' : 'Fees',
                        context: context),
                    threeEmptyRows(7),
                    threeRows(
                      firstLabel: widget.admin
                          ? widget.fee.item.name
                          : widget.fee.paid
                              ? trimDate(widget.fee.paymentDate)
                              : widget.fee.item.name,
                      secondLabel: widget.admin
                          ? trimDate(widget.fee.paymentDate)
                          : widget.fee.paid
                              ? 'Paid'
                              : 'Required To Pay',
                      thirdLabel: widget.admin
                          ? widget.fee.paid
                              ? 'Paid'
                              : 'Required To Pay'
                          : "\$${widget.fee.fees}",
                    ),
                    threeEmptyRows(20),
                  ],
                ),
              ],
            ),
          ),
        ),
        widget.fee.paid
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.admin
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SmallButton(
                              child: Text('Pay'),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PayFeeScreen(fee: widget.fee),
                                  ),
                                );
                              }),
                        )
                ],
              )
      ],
    );
  }
}
