import 'package:LibraryManagmentSystem/classes/borrow_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given availble json data then from json is called', () async {
    // ARRANGE
    BorrowRequestSerializer request = BorrowRequestSerializer();
    final Map<String, dynamic> _requestJson = {
      "_id": "1",
      "borrowed": true,
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
      },
      "library": {
        "_id": "1",
        "image": "image",
        "name": "name",
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
      "deadline": "2021-01-10T23:26:00.205Z",
    };
    // ACT
    request = BorrowRequestSerializer.fromJson(_requestJson);
    // ASSERT
    expect(request.id, "1");
    expect(request.borrowed, true);
    expect(request.deadline, "2021-01-10T23:26:00.205Z");
    expect(request.item.type, "type");
    expect(request.item.genre, "gen");
    expect(request.item.name, "name");
    expect(request.item.isbn, "isbn");
    expect(request.item.author, "auth");
    expect(request.user.id, "1");
    expect(request.user.firstname, "fname");
    expect(request.user.lastname, "lname");
    expect(request.user.email, "user@email.com");
    expect(request.user.librarian, false);
    expect(request.user.canBorrowItems, true);
    expect(request.user.canEvaluateItems, false);
    expect(request.user.username, "username");
    expect(request.library.name, "name");
    expect(request.library.id, "1");
    expect(request.library.image, "image");
  });
}
