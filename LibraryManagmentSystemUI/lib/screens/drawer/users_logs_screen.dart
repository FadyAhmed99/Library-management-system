import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/screens/users_logs/user_borrowing_log.dart';
import 'package:LibraryManagmentSystem/screens/users_logs/user_fees_screen.dart';
import 'package:LibraryManagmentSystem/screens/users_logs/user_returnings_screen.dart';
import 'package:flutter/material.dart';

class UsersLogsScreen extends StatefulWidget {
  @override
  _UsersLogsScreenState createState() => _UsersLogsScreenState();
}

class _UsersLogsScreenState extends State<UsersLogsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: appBar(
              backTheme: false,
              context: context,
              title: 'User\'s Logs',
              bottom: TabBar(
                tabs: [Text('Borrowings'), Text('Returnings'), Text('Fees')],
              ),
            ),
            body: TabBarView(children: [
              UserBorrowingScreen(),
              UserReturningsScreen(),
              UserFeesScreen()
            ])));
  }
}
