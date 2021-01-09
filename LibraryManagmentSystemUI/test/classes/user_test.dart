import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given user json data then from json is called', () async {
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
}
