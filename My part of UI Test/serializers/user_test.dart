import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given user with full json data then fromJson() is called', () async {
    // ARRANGE
    UserSerializer user = UserSerializer();
    final Map<String, dynamic> _userJson = {
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
      "subscribedLibraries": [
        {"status": "pending", "_id": "libraryId"}
      ],
      "favorites": [
        {"_id": "itemId", "libraryId": "libraryId"}
      ],
    };
    // ACT
    user = UserSerializer.fromJson(_userJson);
    // ASSERT
    expect(user.id, "1");
    expect(user.firstname, "fname");
    expect(user.lastname, "lname");
    expect(user.profilePhoto, "photo");
    expect(user.phoneNumber, "number");
    expect(user.email, "user@email.com");
    expect(user.librarian, false);
    expect(user.canBorrowItems, true);
    expect(user.canEvaluateItems, false);
    expect(user.username, "username");
    expect(user.facebookId, "faceid");
    expect(user.subscribedLibraries[0].status, "pending");
    expect(user.subscribedLibraries[0].id, "libraryId");
    expect(user.favorites[0].id, "itemId");
    expect(user.favorites[0].libraryId, "libraryId");
  });
  test('Given user without firstname data then fromJson() is called', () async {
    // ARRANGE
    UserSerializer user = UserSerializer();
    final Map<String, dynamic> _userJson = {
      "_id": "1",
      "lastname": "lname",
      "email": "user@email.com",
      "profilePhoto": "photo",
      "phoneNumber": "number",
      "librarian": false,
      "canBorrowItems": true,
      "canEvaluateItems": false,
      "username": "username",
      "facebookId": "faceid",
      "subscribedLibraries": [
        {"status": "pending", "_id": "libraryId"}
      ],
      "favorites": [
        {"_id": "itemId", "libraryId": "libraryId"}
      ],
    };
    // ACT
    user = UserSerializer.fromJson(_userJson);
    // ASSERT
    expect(user.id, "1");
    expect(user.firstname, "");
    expect(user.profilePhoto, "photo");
    expect(user.phoneNumber, "number");
    expect(user.lastname, "lname");
    expect(user.email, "user@email.com");
    expect(user.librarian, false);
    expect(user.canBorrowItems, true);
    expect(user.canEvaluateItems, false);
    expect(user.username, "username");
    expect(user.facebookId, "faceid");
    expect(user.subscribedLibraries[0].status, "pending");
    expect(user.subscribedLibraries[0].id, "libraryId");
    expect(user.favorites[0].id, "itemId");
    expect(user.favorites[0].libraryId, "libraryId");
  });
  test('Given user without lastname data then fromJson() is called', () async {
    // ARRANGE
    UserSerializer user = UserSerializer();
    final Map<String, dynamic> _userJson = {
      "_id": "1",
      "firstname": "fname",
      "email": "user@email.com",
      "profilePhoto": "photo",
      "phoneNumber": "number",
      "librarian": false,
      "canBorrowItems": true,
      "canEvaluateItems": false,
      "username": "username",
      "facebookId": "faceid",
      "subscribedLibraries": [
        {"status": "pending", "_id": "libraryId"}
      ],
      "favorites": [
        {"_id": "itemId", "libraryId": "libraryId"}
      ],
    };
    // ACT
    user = UserSerializer.fromJson(_userJson);
    // ASSERT
    expect(user.id, "1");
    expect(user.firstname, "fname");
    expect(user.profilePhoto, "photo");
    expect(user.phoneNumber, "number");
    expect(user.lastname, "");
    expect(user.email, "user@email.com");
    expect(user.librarian, false);
    expect(user.canBorrowItems, true);
    expect(user.canEvaluateItems, false);
    expect(user.username, "username");
    expect(user.facebookId, "faceid");
    expect(user.subscribedLibraries[0].status, "pending");
    expect(user.subscribedLibraries[0].id, "libraryId");
    expect(user.favorites[0].id, "itemId");
    expect(user.favorites[0].libraryId, "libraryId");
  });
  test('Given user without email data then fromJson() is called', () async {
    // ARRANGE
    UserSerializer user = UserSerializer();
    final Map<String, dynamic> _userJson = {
      "_id": "1",
      "firstname": "fname",
      "lastname": "lname",
      "profilePhoto": "photo",
      "phoneNumber": "number",
      "librarian": false,
      "canBorrowItems": true,
      "canEvaluateItems": false,
      "username": "username",
      "facebookId": "faceid",
      "subscribedLibraries": [
        {"status": "pending", "_id": "libraryId"}
      ],
      "favorites": [
        {"_id": "itemId", "libraryId": "libraryId"}
      ],
    };
    // ACT
    user = UserSerializer.fromJson(_userJson);
    // ASSERT
    expect(user.id, "1");
    expect(user.firstname, "fname");
    expect(user.lastname, "lname");
    expect(user.email, "");
    expect(user.profilePhoto, "photo");
    expect(user.phoneNumber, "number");
    expect(user.librarian, false);
    expect(user.canBorrowItems, true);
    expect(user.canEvaluateItems, false);
    expect(user.username, "username");
    expect(user.facebookId, "faceid");
    expect(user.subscribedLibraries[0].status, "pending");
    expect(user.subscribedLibraries[0].id, "libraryId");
    expect(user.favorites[0].id, "itemId");
    expect(user.favorites[0].libraryId, "libraryId");
  });
  test('Given user without profilePhoto data then fromJson() is called',
      () async {
    // ARRANGE
    UserSerializer user = UserSerializer();
    final Map<String, dynamic> _userJson = {
      "_id": "1",
      "firstname": "fname",
      "lastname": "lname",
      "email": "user@email.com",
      "phoneNumber": "number",
      "librarian": false,
      "canBorrowItems": true,
      "canEvaluateItems": false,
      "username": "username",
      "facebookId": "faceid",
      "subscribedLibraries": [
        {"status": "pending", "_id": "libraryId"}
      ],
      "favorites": [
        {"_id": "itemId", "libraryId": "libraryId"}
      ],
    };
    // ACT
    user = UserSerializer.fromJson(_userJson);
    // ASSERT
    expect(user.id, "1");
    expect(user.firstname, "fname");
    expect(user.lastname, "lname");
    expect(user.email, "user@email.com");
    expect(user.profilePhoto, "");
    expect(user.phoneNumber, "number");
    expect(user.librarian, false);
    expect(user.canBorrowItems, true);
    expect(user.canEvaluateItems, false);
    expect(user.username, "username");
    expect(user.facebookId, "faceid");
    expect(user.subscribedLibraries[0].status, "pending");
    expect(user.subscribedLibraries[0].id, "libraryId");
    expect(user.favorites[0].id, "itemId");
    expect(user.favorites[0].libraryId, "libraryId");
  });
  test('Given user without phoneNumber data then fromJson() is called',
      () async {
    // ARRANGE
    UserSerializer user = UserSerializer();
    final Map<String, dynamic> _userJson = {
      "_id": "1",
      "firstname": "fname",
      "lastname": "lname",
      "email": "user@email.com",
      "profilePhoto": "photo",
      "librarian": false,
      "canBorrowItems": true,
      "canEvaluateItems": false,
      "username": "username",
      "facebookId": "faceid",
      "subscribedLibraries": [
        {"status": "pending", "_id": "libraryId"}
      ],
      "favorites": [
        {"_id": "itemId", "libraryId": "libraryId"}
      ],
    };
    // ACT
    user = UserSerializer.fromJson(_userJson);
    // ASSERT
    expect(user.id, "1");
    expect(user.firstname, "fname");
    expect(user.lastname, "lname");
    expect(user.email, "user@email.com");
    expect(user.librarian, false);
    expect(user.phoneNumber, '');
    expect(user.profilePhoto, 'photo');
    expect(user.canBorrowItems, true);
    expect(user.canEvaluateItems, false);
    expect(user.username, "username");
    expect(user.facebookId, "faceid");
    expect(user.subscribedLibraries[0].status, "pending");
    expect(user.subscribedLibraries[0].id, "libraryId");
    expect(user.favorites[0].id, "itemId");
    expect(user.favorites[0].libraryId, "libraryId");
  });
  test('Given user without librarian key then fromJson() is called', () async {
    // ARRANGE
    UserSerializer user = UserSerializer();
    final Map<String, dynamic> _userJson = {
      "_id": "1",
      "firstname": "fname",
      "lastname": "lname",
      "email": "user@email.com",
      "profilePhoto": "photo",
      "canBorrowItems": true,
      "canEvaluateItems": false,
      "username": "username",
      "facebookId": "faceid",
      "subscribedLibraries": [
        {"status": "pending", "_id": "libraryId"}
      ],
      "favorites": [
        {"_id": "itemId", "libraryId": "libraryId"}
      ],
    };
    // ACT
    user = UserSerializer.fromJson(_userJson);
    // ASSERT
    expect(user.id, "1");
    expect(user.firstname, "fname");
    expect(user.lastname, "lname");
    expect(user.email, "user@email.com");
    expect(user.librarian, false);
    expect(user.phoneNumber, '');
    expect(user.profilePhoto, 'photo');
    expect(user.canBorrowItems, true);
    expect(user.canEvaluateItems, false);
    expect(user.username, "username");
    expect(user.facebookId, "faceid");
    expect(user.subscribedLibraries[0].status, "pending");
    expect(user.subscribedLibraries[0].id, "libraryId");
    expect(user.favorites[0].id, "itemId");
    expect(user.favorites[0].libraryId, "libraryId");
  });
  test('Given user without canBorrowItems data then fromJson() is called',
      () async {
    // ARRANGE
    UserSerializer user = UserSerializer();
    final Map<String, dynamic> _userJson = {
      "_id": "1",
      "firstname": "fname",
      "lastname": "lname",
      "email": "user@email.com",
      "profilePhoto": "photo",
      "librarian": false,
      "canEvaluateItems": false,
      "username": "username",
      "facebookId": "faceid",
      "subscribedLibraries": [
        {"status": "pending", "_id": "libraryId"}
      ],
      "favorites": [
        {"_id": "itemId", "libraryId": "libraryId"}
      ],
    };
    // ACT
    user = UserSerializer.fromJson(_userJson);
    // ASSERT
    expect(user.id, "1");
    expect(user.firstname, "fname");
    expect(user.lastname, "lname");
    expect(user.email, "user@email.com");
    expect(user.librarian, false);
    expect(user.phoneNumber, '');
    expect(user.profilePhoto, 'photo');
    expect(user.canBorrowItems, false);
    expect(user.canEvaluateItems, false);
    expect(user.username, "username");
    expect(user.facebookId, "faceid");
    expect(user.subscribedLibraries[0].status, "pending");
    expect(user.subscribedLibraries[0].id, "libraryId");
    expect(user.favorites[0].id, "itemId");
    expect(user.favorites[0].libraryId, "libraryId");
  });
  test('Given user without canEvaluateItems data then fromJson() is called',
      () async {
    // ARRANGE
    UserSerializer user = UserSerializer();
    final Map<String, dynamic> _userJson = {
      "_id": "1",
      "firstname": "fname",
      "lastname": "lname",
      "email": "user@email.com",
      "profilePhoto": "photo",
      "librarian": false,
      "canBorrowItems": true,
      "username": "username",
      "facebookId": "faceid",
      "subscribedLibraries": [
        {"status": "pending", "_id": "libraryId"}
      ],
      "favorites": [
        {"_id": "itemId", "libraryId": "libraryId"}
      ],
    };
    // ACT
    user = UserSerializer.fromJson(_userJson);
    // ASSERT
    expect(user.id, "1");
    expect(user.firstname, "fname");
    expect(user.lastname, "lname");
    expect(user.email, "user@email.com");
    expect(user.librarian, false);
    expect(user.phoneNumber, '');
    expect(user.profilePhoto, 'photo');
    expect(user.canBorrowItems, true);
    expect(user.canEvaluateItems, false);
    expect(user.username, "username");
    expect(user.facebookId, "faceid");
    expect(user.subscribedLibraries[0].status, "pending");
    expect(user.subscribedLibraries[0].id, "libraryId");
    expect(user.favorites[0].id, "itemId");
    expect(user.favorites[0].libraryId, "libraryId");
  });
  test('Given user without username data then fromJson() is called', () async {
    // ARRANGE
    UserSerializer user = UserSerializer();
    final Map<String, dynamic> _userJson = {
      "_id": "1",
      "firstname": "fname",
      "lastname": "lname",
      "email": "user@email.com",
      "profilePhoto": "photo",
      "librarian": false,
      "canBorrowItems": true,
      "canEvaluateItems": false,
      "facebookId": "faceid",
      "subscribedLibraries": [
        {"status": "pending", "_id": "libraryId"}
      ],
      "favorites": [
        {"_id": "itemId", "libraryId": "libraryId"}
      ],
    };
    // ACT
    user = UserSerializer.fromJson(_userJson);
    // ASSERT
    expect(user.id, "1");
    expect(user.firstname, "fname");
    expect(user.lastname, "lname");
    expect(user.email, "user@email.com");
    expect(user.librarian, false);
    expect(user.phoneNumber, '');
    expect(user.profilePhoto, 'photo');
    expect(user.canBorrowItems, true);
    expect(user.canEvaluateItems, false);
    expect(user.username, "");
    expect(user.facebookId, "faceid");
    expect(user.subscribedLibraries[0].status, "pending");
    expect(user.subscribedLibraries[0].id, "libraryId");
    expect(user.favorites[0].id, "itemId");
    expect(user.favorites[0].libraryId, "libraryId");
  });

  test('Given user object with full then toJson() function is called', () async {
    // ARRANGE
    UserSerializer user = UserSerializer(
      firstname: "fname",
      lastname: "lname",
      username: "username",
      email: "user@email.com",
      canBorrowItems: true,
      canEvaluateItems: true,
      librarian: false,
      profilePhoto: "photo",
    );

    // ACT
    Map<String, dynamic> _userJson = user.toJson();

    // ASSERT
    expect(_userJson['firstname'], "fname");
    expect(_userJson['lastname'], "lname");
    expect(_userJson['email'], "user@email.com");
    expect(_userJson['librarian'], false);
    expect(_userJson['canBorrowItems'], true);
    expect(_userJson['canEvaluateItems'], true);
    expect(_userJson['profilePhoto'], 'photo');
    expect(_userJson['username'], "username");
  });

  test(
      'Given user object without email and profilePhoto then toJson() function is called',
      () async {
    // ARRANGE
    UserSerializer user = UserSerializer(
      firstname: "fname",
      lastname: "lname",
      username: "username",
      phoneNumber: "num",
    );

    // ACT
    Map<String, dynamic> _userJson = user.toJson();

    // ASSERT
    expect(_userJson['firstname'], "fname");
    expect(_userJson['lastname'], "lname");
    expect(_userJson['phoneNumber'], "num");
    expect(_userJson['username'], "username");
  });
}
