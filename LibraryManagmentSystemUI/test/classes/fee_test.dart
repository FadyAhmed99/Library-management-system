import 'package:LibraryManagmentSystem/classes/fee.dart';
import 'package:LibraryManagmentSystem/classes/item.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given fee json data then fromJson() is called', () async {
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
    expect(fee.item.name, "name");
    expect(fee.item.isbn, "isbn");
    expect(fee.item.author, "auth");
    expect(fee.transactionId, "transactionId");
  });

 test('Given fee object then toJson() is called', () async {
    FeeSerializer fee = FeeSerializer();
    fee = FeeSerializer(
        id: "1",
        creditCardInfo: "5665312313255122",
        paid: true,
        transactionId: "transactionId",
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
        item: ItemSerializer(
          id: "1",
          isbn: "isbn",
          name: "name",
          genre: "gen",
          author: "auth",
          type: "type",
          language: "lang",
        ),
        fees: 150,
        ccv: 235,
        paymentDate: DateTime.parse("2021-01-09T01:04:40.687Z"));
    // ACT
    final Map<String, dynamic> _feeJson = fee.toJson();
    // ASSERT
    expect(_feeJson['_id'], "1");
    expect(_feeJson['creditCardInfo'], "5665312313255122");
    expect(_feeJson['paid'], true);
    expect(_feeJson['fees'], 150);
    expect(_feeJson['ccv'], 235);
    expect(_feeJson['item']['type'], "type");
    expect(_feeJson['item']['genre'], "gen");
    expect(_feeJson['item']['name'], "name");
    expect(_feeJson['item']['ISBN'], "isbn");
    expect(_feeJson['item']['author'], "auth");
    expect(_feeJson['transactionId'], "transactionId");
  });
}
