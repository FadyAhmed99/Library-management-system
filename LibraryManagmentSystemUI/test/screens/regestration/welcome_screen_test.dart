import 'package:LibraryManagmentSystem/classes/borrow_request.dart';
import 'package:LibraryManagmentSystem/classes/favorite.dart';
import 'package:LibraryManagmentSystem/classes/fee.dart';
import 'package:LibraryManagmentSystem/classes/feedback.dart' as feed;
import 'package:LibraryManagmentSystem/classes/item.dart';
import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:LibraryManagmentSystem/screens/regestration/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('welcome screen shows logo, log in and Register button',
      (tester) async {
    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => User()),
      ChangeNotifierProvider(create: (context) => Library()),
      ChangeNotifierProvider(create: (context) => BorrowRequest()),
      ChangeNotifierProvider(create: (context) => Favorite()),
      ChangeNotifierProvider(create: (context) => Fee()),
      ChangeNotifierProvider(create: (context) => feed.Feedback()),
      ChangeNotifierProvider(create: (context) => Item()),
      ChangeNotifierProvider(create: (context) => Transaction()),
    ], child: MaterialApp(home: WelcomeScreen())));

    expect(find.byKey(ValueKey('label')), findsOneWidget);
  });
}
