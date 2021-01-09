import 'package:LibraryManagmentSystem/components/admin_returnings_tile.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SystemReturningScreen extends StatefulWidget {
  @override
  _SystemReturningScreenState createState() => _SystemReturningScreenState();
}

class _SystemReturningScreenState extends State<SystemReturningScreen> {
  bool _init = true;
  bool _loading = true;
  List<TransactionSerializer> _transactions = [];

  @override
  void didChangeDependencies() {
    if (_init) {
      final _userProvider = Provider.of<User>(context);

      _userProvider.getSystemReturnings().then((_) {
        setState(() {
          _loading = false;
          _transactions = _userProvider.systemReturnings;
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
              await _userProvider.getSystemReturnings();
            },
            child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  return ReturningTile(
                    transaction: _transactions[index],
                    borrowing: false,
                  );
                }),
          );
  }
}
