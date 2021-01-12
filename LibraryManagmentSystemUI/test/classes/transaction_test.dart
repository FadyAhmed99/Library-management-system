import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given transaction json data then from json is called', () async {
    // ARRANGE
    TransactionSerializer transaction = TransactionSerializer();
    final Map<String, dynamic> _transactionJson = {
      "user": {
        "_id": "1",
        "firstname": "fname",
        "lastname": "lname",
        "email": "user@email.com",
        "profilePhoto": "photo",
        "phoneNumber": "number",
        "librarian": false,
        "canBorrowItems": true,
        "canEvaluateItems": false,
        "username": "username",
        "facebookId": "faceid",
      },
      "_id": "1",
      "returned": true,
      "lateFees": 50,
      "deadline": "2021-01-06T20:08:44.179Z",
      "requestedToReturn": true,
      "hasFees": false,
      "returnDate": "2021-01-08T20:09:44.646Z"
    };
    // ACT
    transaction = TransactionSerializer.fromJson(_transactionJson);
    // ASSERT
    expect(transaction.returned, true);
    expect(transaction.id, "1");
    expect(transaction.lateFees, 50);
    expect(transaction.requestedToReturn, true);
    expect(transaction.hasFees, false);
    expect(transaction.user.id, "1");
    expect(transaction.user.firstname, "fname");
    expect(transaction.user.lastname, "lname");
    expect(transaction.user.profilePhoto, "photo");
  });

  test('Given transaction json data then from json is called', () async {
    // ARRANGE
    TransactionSerializer transaction = TransactionSerializer();
    transaction = TransactionSerializer(
        user: UserSerializer(
          id: "1",
          firstname: "fname",
          lastname: "lname",
          email: "user@email.com",
          profilePhoto: "photo",
          phoneNumber: "number",
          librarian: false,
          canBorrowItems: true,
          canEvaluateItems: false,
          username: "username",
          facebookId: "faceid",
        ),
        id: "1",
        returned: true,
        lateFees: 50,
        deadline: DateTime.parse("2021-01-06T20:08:44.179Z"),
        requestedToReturn: true,
        hasFees: false,
        returnDate: DateTime.parse("2021-01-08T20:09:44.646Z"));
    // ACT
    final Map<String, dynamic> _transactionJson = transaction.toJson();
    // ASSERT
    expect(_transactionJson['returned'], true);
    expect(_transactionJson['_id'], "1");
    expect(_transactionJson['lateFees'], 50);
    expect(_transactionJson['requestedToReturn'], true);
    expect(_transactionJson['hasFees'], false);
    expect(_transactionJson['user']['_id'], "1");
    expect(_transactionJson['user']['firstname'], "fname");
    expect(_transactionJson['user']['lastname'], "lname");
    expect(_transactionJson['user']['profilePhoto'], "photo");
  });
}
