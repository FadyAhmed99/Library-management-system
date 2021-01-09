import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/expansion_returnings_tile.dart';
import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserReturningsScreen extends StatefulWidget {
  @override
  _UserReturningsScreenState createState() => _UserReturningsScreenState();
}

class _UserReturningsScreenState extends State<UserReturningsScreen> {
  bool _init = true;
  bool _loading = true;
  List<TransactionSerializer> _transactions = [];
  @override
  void didChangeDependencies() {
    if (_init) {
      final _transactionProvider = Provider.of<Transaction>(context);

      _transactionProvider.getReturningLogs().then((_) {
        setState(() {
          _loading = false;
          _transactions = _transactionProvider.transactions;
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
              await _transactionProvider.getReturningLogs();
            },
            child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  return ReturningsExpansionTile(
                    transaction: _transactions[index],
                  );
                }),
          );
  }
}
