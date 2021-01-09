import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/expansion_tile.dart';
import 'package:LibraryManagmentSystem/classes/borrow_request.dart';

import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserBorrowingScreen extends StatefulWidget {
  @override
  _UserBorrowingScreenState createState() => _UserBorrowingScreenState();
}

class _UserBorrowingScreenState extends State<UserBorrowingScreen> {
  bool _init = true;
  bool _loading = true;
  List<TransactionSerializer> _transactions = [];
  List<BorrowRequestSerializer> _borrowRequests = [];
  @override
  void didChangeDependencies() async {
    if (_init) {
      final _transactionProvider = Provider.of<Transaction>(context);

      _transactionProvider.getBorrowinglogs().then((_) {
        setState(() {
          _loading = false;
          _transactions = _transactionProvider.transactions;
          _borrowRequests = _transactionProvider.borrowRequests;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _transactionProvider = Provider.of<Transaction>(context);

    return _loading
        ? loading()
        : RefreshIndicator(
            onRefresh: () async {
              await _transactionProvider.getBorrowinglogs();
            },
            child: ListView.builder(
                itemCount: _transactions.length + _borrowRequests.length,
                itemBuilder: (context, index) {
                  return index < _borrowRequests.length
                      ? CustomExpantionTile(
                          borrowRequest: _borrowRequests[index],
                        )
                      : CustomExpantionTile(
                          transaction: _transactions[
                              (index - _borrowRequests.length).abs()],
                        );
                }),
          );
  }
}
