import 'package:LibraryManagmentSystem/classes/borrow_request.dart';
import 'package:LibraryManagmentSystem/classes/item.dart';
import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given borrow request json full data then fromJson() is called',
      () async {
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
  test(
      'Given borrowRequest json without borrowed flag then fromJson() is called',
      () async {
    // ARRANGE
    BorrowRequestSerializer request = BorrowRequestSerializer();
    final Map<String, dynamic> _requestJson = {
      "_id": "1",
      "deadline": "2021-01-10T23:26:00.205Z",
    };
    // ACT
    request = BorrowRequestSerializer.fromJson(_requestJson);
    // ASSERT
    expect(request.id, "1");
    expect(request.borrowed, false);
    expect(request.deadline, "2021-01-10T23:26:00.205Z");
  });
  test('Given borrow request json without deadline then fromJson() is called',
      () async {
    // ARRANGE
    BorrowRequestSerializer request = BorrowRequestSerializer();
    final Map<String, dynamic> _requestJson = {
      "_id": "1",
      "borrowed": true,
    };
    // ACT
    request = BorrowRequestSerializer.fromJson(_requestJson);
    // ASSERT
    expect(request.id, "1");
    expect(request.borrowed, true);
    expect(request.deadline, '');
  });

  test('Given borrowRequest object then toJson() is called', () async {
    // ARRANGE
    BorrowRequestSerializer request = BorrowRequestSerializer(
      id: "1",
      borrowed: true,
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
      ),
      library: LibrarySerializer(
        id: "1",
        image: "image",
        name: "name",
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
      deadline: "2021-01-10T23:26:00.205Z",
    );
    // ACT
    Map<String, dynamic> _requestJson = request.toJson();
    // ASSERT
    expect(_requestJson['_id'], "1");
    expect(_requestJson['borrowed'], true);
    expect(_requestJson['deadline'], "2021-01-10T23:26:00.205Z");
    expect(_requestJson['item']['type'], "type");
    expect(_requestJson['item']['genre'], "gen");
    expect(_requestJson['item']['name'], "name");
    expect(_requestJson['item']['ISBN'], "isbn");
    expect(_requestJson['item']['author'], "auth");
    expect(_requestJson['user']['_id'], "1");
    expect(_requestJson['user']['firstname'], "fname");
    expect(_requestJson['user']['lastname'], "lname");
    expect(_requestJson['user']['email'], "user@email.com");
    expect(_requestJson['user']['librarian'], false);
    expect(_requestJson['user']['canBorrowItems'], true);
    expect(_requestJson['user']['canEvaluateItems'], false);
    expect(_requestJson['user']['username'], "username");
    expect(_requestJson['library']['name'], "name");
    expect(_requestJson['library']['_id'], "1");
    expect(_requestJson['library']['image'], "image");
  });
}
