
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:LibraryManagmentSystem/screens/regestration/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('profile renders data correctly', (WidgetTester tester) async {
    User user = User();
    final _providerKey = GlobalKey();
    BuildContext context;

    await tester.pumpWidget(Provider(
      key: _providerKey,
      create: (c) => 42,
      child: Profile(
        edit: false,
      ),
    ));

    final userNameFinder = find.text('First name');

    expect(Provider.of<int>(context), equals(42));
  });
}
