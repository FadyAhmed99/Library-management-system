import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/small_button.dart';
import 'package:LibraryManagmentSystem/components/table_row.dart';
import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:LibraryManagmentSystem/components/trim_date.dart';
import 'package:LibraryManagmentSystem/screens/review_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BorrowingRecipt extends StatefulWidget {
  final String transactionId;
  BorrowingRecipt({this.transactionId});
  @override
  _BorrowingReciptState createState() => _BorrowingReciptState();
}

class _BorrowingReciptState extends State<BorrowingRecipt> {
  bool _loading = true;
  bool _init = true;
  int lateDays;
  TransactionSerializer _item;
  String lateFees;
  String status;
  @override
  void didChangeDependencies() {
    if (_init) {
      final _transactionProvider = Provider.of<Transaction>(context);

      _transactionProvider
          .exactTransaction(transactionId: widget.transactionId)
          .then((_) {
        setState(() {
          _item = _transactionProvider.reciept;
          _loading = false;
          lateDays = (DateTime.now().difference(_item.deadline).inDays) > 0
              ? 'Over Dued'
              : (DateTime.now().difference(_item.deadline).inDays);
        });
        if (lateDays > 0)
          lateFees = '\$${_item.lateFees / 100 * lateDays}';
        else
          lateFees = 'No Fees yet';

        if (_item.returned) {
          status = 'Returned with Late Fees';
        } else if (_item.requestedToReturn) {
          status = 'Requested To Return';
        }
        status = 'Borrowed';
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _transactionProvider = Provider.of<Transaction>(context);

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar:
            appBar(context: context, title: 'Borrow Recipt', backTheme: true),
        body: _loading
            ? loading()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Table(children: [
                      emptyRow(),
                      row('Name', _item.item.name, context),
                      emptyRow(),
                      row('Author', _item.item.author, context),
                      emptyRow(),
                      row('Borrowing Date ', trimDate(_item.borrowDate),
                          context),
                      emptyRow(),
                      row('Due In', "${lateDays.abs()} days", context),
                      emptyRow(),
                      row('Late Fees', "\$${_item.lateFees / 100} /day",
                          context),
                      emptyRow(),
                      row('Status', status, context),
                      emptyRow(),
                      row('Required Fees', lateFees, context),
                      emptyRow(),
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width / 2,
                              child: SmallButton(
                                onPressed: () {
                                  _transactionProvider
                                      .sendRequestToReturn(
                                          transactionId: widget.transactionId)
                                      .then((value) async {
                                    if (value != null)
                                      ourDialog(context: context, error: value);
                                    else {
                                      await _transactionProvider
                                          .userBorrowings()
                                          .then((err) {
                                        // Scaffold.of(context)
                                        //     .showSnackBar(SnackBar(
                                        //   duration: Duration(seconds: 3),
                                        //   content: Text(
                                        //       "Requested to return successfully"),
                                        // ));
                                        Navigator.pop(context);
                                      });
                                    }
                                  });
                                },
                                child: Text(
                                  'Request To Return',
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width / 2,
                              child: SmallButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ReviewItemScreen(
                                            itemId: _item.item.id,
                                            libraryId: _item.borrowedFrom.id,
                                            itemName: _item.item.name,
                                          )));
                                },
                                child: Text(
                                  'Review Item',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       width: width / 2,
                    //       child: SmallButton(
                    //         onPressed: () {},
                    //         child: Text('Pay Fees'),
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ));
  }
}
