import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTest extends StatefulWidget {
  @override
  _MyTestState createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  @override
  Widget build(BuildContext context) {
    final _transactionProvider = Provider.of<Transaction>(context);
    _transactionProvider.getUserBorrowings();
    return Container();
  }
}
