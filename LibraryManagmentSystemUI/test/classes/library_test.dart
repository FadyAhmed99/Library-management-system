import 'package:LibraryManagmentSystem/classes/feedback.dart';
import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given library json data then fromJson() is called', () async {
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
      "phoneNumber": "012"
    };
    // ACT
    lib = LibrarySerializer.fromJson(_libraryJson);
    // ASSERT
    expect(lib.id, "1");
    expect(lib.name, "name");
    expect(lib.image, "image");
    expect(lib.address, "12 m");
    expect(lib.description, "desc");
    expect(lib.phoneNumber, "012");
    expect(lib.feedback[0].userId, "1");
    expect(lib.feedback[0].feedback, "feed");
    expect(lib.feedback[0].firstname, "fname");
    expect(lib.feedback[0].lastname, "lname");
    expect(lib.feedback[0].profilePhoto, "photo");
  });

  test('Given library object then toJson() is called', () async {
    // ARRANGE
    LibrarySerializer library = LibrarySerializer();
    library = LibrarySerializer(
      id: "1",
      name: "name",
      librarian: "user",
      image: "image",
      address: "12 m",
      description: "desc",
      phoneNumber: "012",
      feedback: [
        FeedbackSerializer(
          feedback: "feed",
          userId: "1",
          firstname: "fname",
          lastname: "lname",
          profilePhoto: "photo",
        )
      ],
    );
    // ACT
    final Map<String, dynamic> _libraryJson = library.toJson();
    // ASSERT
    expect(_libraryJson['_id'], "1");
    expect(_libraryJson['name'], "name");
    expect(_libraryJson['image'], "image");
    expect(_libraryJson['address'], "12 m");
    expect(_libraryJson['description'], "desc");
    expect(_libraryJson['phoneNumber'], "012");
    expect(_libraryJson['feedback'][0]['userId'], "1");
    expect(_libraryJson['feedback'][0]['feedback'], "feed");
    expect(_libraryJson['feedback'][0]['firstname'], "fname");
    expect(_libraryJson['feedback'][0]['lastname'], "lname");
    expect(_libraryJson['feedback'][0]['profilePhoto'], "photo");
  });
}
