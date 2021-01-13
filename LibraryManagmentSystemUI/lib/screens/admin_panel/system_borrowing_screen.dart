import 'package:LibraryManagmentSystem/components/admin_returnings_tile.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/expansion_tile.dart';
import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SystemBorrowingScreen extends StatefulWidget {
  @override
  _SystemBorrowingScreenState createState() => _SystemBorrowingScreenState();
}

class _SystemBorrowingScreenState extends State<SystemBorrowingScreen> {
  bool _init = true;
  bool _loading = true;
  List<TransactionSerializer> _transactions = [];
  @override
  void didChangeDependencies() {
    if (_init) {
      final _userProvider = Provider.of<User>(context);

      _userProvider.getSystemBorrowedItems().then((_) {
        setState(() {
          _loading = false;
          _transactions = _userProvider.allBorrowedItems;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<User>(context);
    return _loading
        ? loading()
        : RefreshIndicator(
            onRefresh: () async {
              await _userProvider.getSystemBorrowedItems();
            },
            child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  return ReturningTile(
                      transaction: _transactions[index], borrowing: true);
                }),
          );
  }
}
