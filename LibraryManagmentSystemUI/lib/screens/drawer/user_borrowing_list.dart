import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/borrowed_item_tile.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/classes/borrow_request.dart';
import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../borrowing_reciept.dart';

class UserBorrowingList extends StatefulWidget {
  final String libraryId;

  const UserBorrowingList({Key key, this.libraryId}) : super(key: key);
  @override
  _UserBorrowingListState createState() => _UserBorrowingListState();
}

class _UserBorrowingListState extends State<UserBorrowingList> {
  bool _loading = true;
  bool _init = true;

  List<TransactionSerializer> _items = [];
  List<BorrowRequestSerializer> _requests = [];
  int length = 0;
  @override
  void didChangeDependencies() {
    if (_init) {
      final _transactionProvider = Provider.of<Transaction>(context);
      final _borrowRequestProvider = Provider.of<BorrowRequest>(context);

      _transactionProvider.getUserBorrowings().then((_) {
        _transactionProvider.getBorrowinglogs().then((value) {
          setState(() {
            _loading = false;
            _items = _transactionProvider.borrowedItems;
          });
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _transactionProvider = Provider.of<Transaction>(context);
    final _borrowRequestProvider = Provider.of<BorrowRequest>(context);

    _requests = _borrowRequestProvider.requests;
    _items = _transactionProvider.borrowedItems;

    // _userProvider.userBorrowings();
    final _user = Provider.of<User>(context).user;
    int remain = (3 -
            (_transactionProvider.transactions.length +
                _transactionProvider.borrowRequests.length))
        .abs();
    return Scaffold(
      appBar: appBar(
        title: 'Borrowed Items',
        context: context,
        backTheme: false,
      ),
      body: _loading
          ? loading()
          : RefreshIndicator(
              onRefresh: () async {
                await _transactionProvider.getUserBorrowings();
                await _borrowRequestProvider.getUserBorrowRequests();
                _items = _transactionProvider.borrowedItems;
                _requests = _borrowRequestProvider.requests;
              },
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Text(
                    !_user.canBorrowItems
                        ? 'You\'r blocked from borrowing items'
                        : 'You can borrow $remain more items',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GridView.builder(
                        gridDelegate: kGridShape(context: context),
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            Expanded(
                              child: BorrowedItemTile(
                                transaction: _items[index],
                                libraryId: widget.libraryId,
                                transactionId: _items[index].id,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => BorrowingRecipt(
                                            transactionId: _items[index].id,
                                          )));
                                },
                                child: Text(
                                  "Borrowing Reciept",
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 12),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              ),
                            ),
                          ]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
