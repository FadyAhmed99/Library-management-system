import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/screens/admin_panel/system_borrowing_screen.dart';
import 'package:LibraryManagmentSystem/screens/admin_panel/system_fees_log_scree.dart';
import 'package:LibraryManagmentSystem/screens/admin_panel/system_returnings_log_screen.dart';
import 'package:flutter/material.dart';

class SystemLogsScreen extends StatefulWidget {
  @override
  _SystemLogsScreenState createState() => _SystemLogsScreenState();
}

class _SystemLogsScreenState extends State<SystemLogsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: appBar(
              context: context,
              backTheme: false,
              title: 'System\'s Users Log',
              bottom: TabBar(
                tabs: [Text('Borrowings'), Text('Returnings'), Text('Fees')],
              ),
            ),
            body: TabBarView(children: [
              SystemBorrowingScreen(),
              SystemReturningScreen(),
              SystemFeesScreen()
            ])));
  }
}
