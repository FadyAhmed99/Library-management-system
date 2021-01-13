import 'package:LibraryManagmentSystem/classes/fee.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given fee full json data then fromJson() is called', () async {
    FeeSerializer fee = FeeSerializer();
    final Map<String, dynamic> _feeJson = {
      "_id": "1",
      "creditCardInfo": "5665312313255122",
      "paid": true,
      "transactionId": "transactionId",
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
      "item": {
        "_id": "1",
        "ISBN": "isbn",
        "name": "name",
        "genre": "gen",
        "author": "auth",
        "type": "type",
        "language": "lang",
      },
      "fees": 150,
      "ccv": 235,
      "paymentDate": "2021-01-09T01:04:40.687Z"
    };
    // ACT
    fee = FeeSerializer.fromJson(_feeJson);
    // ASSERT
    expect(fee.id, "1");
    expect(fee.creditCardInfo, "5665312313255122");
    expect(fee.paid, true);
    expect(fee.fees, 150);
    expect(fee.ccv, 235);
    expect(fee.item.type, "type");
    expect(fee.item.genre, "gen");
    expect(fee.paymentDate, DateTime.parse("2021-01-09T01:04:40.687Z"));
    expect(fee.item.name, "name");
    expect(fee.item.isbn, "isbn");
    expect(fee.item.author, "auth");
    expect(fee.transactionId, "transactionId");
  });

  test('Given fee json data without paid flag then fromJson() is called',
      () async {
    FeeSerializer fee = FeeSerializer();
    final Map<String, dynamic> _feeJson = {
      "_id": "1",
      "creditCardInfo": "5665312313255122",
      "transactionId": "transactionId",
      "fees": 150,
      "ccv": 235,
      "paymentDate": "2021-01-09T01:04:40.687Z"
    };
    // ACT
    fee = FeeSerializer.fromJson(_feeJson);
    // ASSERT
    expect(fee.id, "1");
    expect(fee.creditCardInfo, "5665312313255122");
    expect(fee.paid, false);
    expect(fee.fees, 150);
    expect(fee.paymentDate, DateTime.parse("2021-01-09T01:04:40.687Z"));

    expect(fee.ccv, 235);
    expect(fee.transactionId, "transactionId");
  });

  test('Given fee json data without creditCardInfo then fromJson() is called',
      () async {
    FeeSerializer fee = FeeSerializer();
    final Map<String, dynamic> _feeJson = {
      "_id": "1",
      "paid": true,
      "transactionId": "transactionId",
      "fees": 150,
      "ccv": 235,
      "paymentDate": "2021-01-09T01:04:40.687Z"
    };
    // ACT
    fee = FeeSerializer.fromJson(_feeJson);
    // ASSERT
    expect(fee.id, "1");
    expect(fee.creditCardInfo, "");
    expect(fee.paymentDate, DateTime.parse("2021-01-09T01:04:40.687Z"));

    expect(fee.paid, true);
    expect(fee.fees, 150);
    expect(fee.ccv, 235);
    expect(fee.transactionId, "transactionId");
  });

  test('Given fee json data without transactionId then fromJson() is called',
      () async {
    FeeSerializer fee = FeeSerializer();
    final Map<String, dynamic> _feeJson = {
      "_id": "1",
      "creditCardInfo": "5665312313255122",
      "paid": true,
      "fees": 150,
      "ccv": 235,
      "paymentDate": "2021-01-09T01:04:40.687Z"
    };
    // ACT
    fee = FeeSerializer.fromJson(_feeJson);
    // ASSERT
    expect(fee.id, "1");
    expect(fee.creditCardInfo, "5665312313255122");
    expect(fee.paid, true);
    expect(fee.fees, 150);
    expect(fee.paymentDate, DateTime.parse("2021-01-09T01:04:40.687Z"));

    expect(fee.ccv, 235);
    expect(fee.transactionId, "");
  });

  test('Given fee json data without fees then fromJson() is called', () async {
    FeeSerializer fee = FeeSerializer();
    final Map<String, dynamic> _feeJson = {
      "_id": "1",
      "creditCardInfo": "5665312313255122",
      "paid": true,
      "transactionId": "transactionId",
      "ccv": 235,
      "paymentDate": "2021-01-09T01:04:40.687Z"
    };
    // ACT
    fee = FeeSerializer.fromJson(_feeJson);
    // ASSERT
    expect(fee.id, "1");
    expect(fee.creditCardInfo, "5665312313255122");
    expect(fee.paid, true);
    expect(fee.fees, null);
    expect(fee.ccv, 235);
    expect(fee.paymentDate, DateTime.parse("2021-01-09T01:04:40.687Z"));
    expect(fee.transactionId, "transactionId");
  });

  test('Given fee json data without ccv then fromJson() is called', () async {
    FeeSerializer fee = FeeSerializer();
    final Map<String, dynamic> _feeJson = {
      "_id": "1",
      "creditCardInfo": "5665312313255122",
      "paid": true,
      "transactionId": "transactionId",
      "fees": 150,
      "paymentDate": "2021-01-09T01:04:40.687Z"
    };
    // ACT
    fee = FeeSerializer.fromJson(_feeJson);
    // ASSERT
    expect(fee.id, "1");
    expect(fee.creditCardInfo, "5665312313255122");
    expect(fee.paid, true);
    expect(fee.fees, 150);
    expect(fee.ccv, null);
    expect(fee.paymentDate, DateTime.parse("2021-01-09T01:04:40.687Z"));
    expect(fee.transactionId, "transactionId");
  });

  test('Given fee json data without paymentDate then fromJson() is called',
      () async {
    FeeSerializer fee = FeeSerializer();
    final Map<String, dynamic> _feeJson = {
      "_id": "1",
      "creditCardInfo": "5665312313255122",
      "paid": true,
      "transactionId": "transactionId",
      "fees": 150,
      "ccv": 235,
    };
    // ACT
    fee = FeeSerializer.fromJson(_feeJson);
    // ASSERT
    expect(fee.id, "1");
    expect(fee.creditCardInfo, "5665312313255122");
    expect(fee.paid, true);
    expect(fee.paymentDate, null);
    expect(fee.fees, 150);
    expect(fee.ccv, 235);
    expect(fee.transactionId, "transactionId");
  });
}
