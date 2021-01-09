import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given library json data then from json is called', () async {
    // ARRANGE
    LibrarySerializer lib = LibrarySerializer();
    final Map<String, dynamic> _libraryJson = {
      "_id": "1",
      "name": "name",
      "librarian": "user",
      "image": "image",
      "address": "12 m",
      "description": "desc",
      "feedback": [
        {
          "feedback": "feed",
          "userId": "1",
          "firstname": "fname",
          "lastname": "lname",
          "profilePhoto": "photo",
        }
      ],
      "phoneNumber": "12"
    };
    // ACT
    lib = LibrarySerializer.fromJson(_libraryJson);
    // ASSERT
    expect(lib.id, "1");
    expect(lib.name, "name");
    expect(lib.image, "image");
    expect(lib.address, "12 m");
    expect(lib.description, "desc");
    expect(lib.phoneNumber, "12");
    expect(lib.feedback[0].userId, "1");
    expect(lib.feedback[0].feedback, "feed");
    expect(lib.feedback[0].firstname, "fname");
    expect(lib.feedback[0].lastname, "lname");
    expect(lib.feedback[0].profilePhoto, "photo");
  });
}
