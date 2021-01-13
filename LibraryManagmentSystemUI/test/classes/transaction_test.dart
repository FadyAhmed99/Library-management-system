import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given transaction full json data then from json is called', () async {
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
    expect(transaction.user.phoneNumber, "number");
    expect(transaction.user.email, "user@email.com");
    expect(transaction.user.librarian, false);
    expect(transaction.user.canBorrowItems, true);
    expect(transaction.user.canEvaluateItems, false);
    expect(transaction.user.username, "username");
    expect(transaction.user.facebookId, "faceid");
  });

  test(
      'Given transaction json data without returned key then from json is called',
      () async {
    // ARRANGE
    TransactionSerializer transaction = TransactionSerializer();
    final Map<String, dynamic> _transactionJson = {
      "_id": "1",
      "lateFees": 50,
      "deadline": "2021-01-06T20:08:44.179Z",
      "requestedToReturn": true,
      "hasFees": false,
      "returnDate": "2021-01-08T20:09:44.646Z"
    };
    // ACT
    transaction = TransactionSerializer.fromJson(_transactionJson);
    // ASSERT
    expect(transaction.returned, false);
    expect(transaction.id, "1");
    expect(transaction.lateFees, 50);
    expect(transaction.requestedToReturn, true);
    expect(transaction.hasFees, false);
  });

  test(
      'Given transaction json data without lateFees key then from json is called',
      () async {
    // ARRANGE
    TransactionSerializer transaction = TransactionSerializer();
    final Map<String, dynamic> _transactionJson = {
      "_id": "1",
      "deadline": "2021-01-06T20:08:44.179Z",
      "requestedToReturn": true,
      "hasFees": false,
      "returnDate": "2021-01-08T20:09:44.646Z"
    };
    // ACT
    transaction = TransactionSerializer.fromJson(_transactionJson);
    // ASSERT
    expect(transaction.returned, false);
    expect(transaction.id, "1");
    expect(transaction.lateFees, 0);
    expect(transaction.requestedToReturn, true);
    expect(transaction.hasFees, false);
  });

  test(
      'Given transaction json data without deadline key then from json is called',
      () async {
    // ARRANGE
    TransactionSerializer transaction = TransactionSerializer();
    final Map<String, dynamic> _transactionJson = {
      "_id": "1",
      "lateFees": 50,
      "requestedToReturn": true,
      "hasFees": false,
      "returnDate": "2021-01-08T20:09:44.646Z"
    };
    // ACT
    transaction = TransactionSerializer.fromJson(_transactionJson);
    // ASSERT
    expect(transaction.returned, false);
    expect(transaction.id, "1");
    expect(transaction.deadline, null);
    expect(transaction.returnDate, DateTime.parse("2021-01-08T20:09:44.646Z"));
    expect(transaction.lateFees, 50);
    expect(transaction.requestedToReturn, true);
    expect(transaction.hasFees, false);
  });

  test(
      'Given transaction json data without requestedToReturn key then from json is called',
      () async {
    // ARRANGE
    TransactionSerializer transaction = TransactionSerializer();
    final Map<String, dynamic> _transactionJson = {
      "_id": "1",
      "lateFees": 50,
      "deadline": "2021-01-06T20:08:44.179Z",
      "hasFees": false,
      "returnDate": "2021-01-08T20:09:44.646Z"
    };
    // ACT
    transaction = TransactionSerializer.fromJson(_transactionJson);
    // ASSERT
    expect(transaction.returned, false);
    expect(transaction.id, "1");
    expect(transaction.lateFees, 50);
    expect(transaction.requestedToReturn, false);
    expect(transaction.hasFees, false);
  });

  test(
      'Given transaction json data without hasFees key then from json is called',
      () async {
    // ARRANGE
    TransactionSerializer transaction = TransactionSerializer();
    final Map<String, dynamic> _transactionJson = {
      "_id": "1",
      "lateFees": 50,
      "deadline": "2021-01-06T20:08:44.179Z",
      "requestedToReturn": true,
      "returnDate": "2021-01-08T20:09:44.646Z"
    };
    // ACT
    transaction = TransactionSerializer.fromJson(_transactionJson);
    // ASSERT
    expect(transaction.returned, false);
    expect(transaction.id, "1");
    expect(transaction.lateFees, 50);
    expect(transaction.requestedToReturn, true);
    expect(transaction.hasFees, false);
  });

  test(
      'Given transaction json data without returnDate key then from json is called',
      () async {
    // ARRANGE
    TransactionSerializer transaction = TransactionSerializer();
    final Map<String, dynamic> _transactionJson = {
      "_id": "1",
      "lateFees": 50,
      "deadline": "2021-01-06T20:08:44.179Z",
      "requestedToReturn": true,
      "hasFees": false,
    };
    // ACT
    transaction = TransactionSerializer.fromJson(_transactionJson);
    // ASSERT
    expect(transaction.returned, false);
    expect(transaction.id, "1");
    expect(transaction.lateFees, 50);
    expect(transaction.returnDate, null);
    expect(transaction.deadline, DateTime.parse("2021-01-06T20:08:44.179Z"));
    expect(transaction.lateFees, 50);
    expect(transaction.requestedToReturn, true);
    expect(transaction.hasFees, false);
  });
}
