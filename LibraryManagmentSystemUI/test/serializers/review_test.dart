import 'package:LibraryManagmentSystem/serializers/review.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given review json data then from json is called', () async {
    // ARRANGE
    Review item = Review();
    final Map<String, dynamic> _libraryJson = {
      "firstname": "fname",
      "lastname": "lname",
      "profilePhoto": "image",
      "rating": 2.4,
      "review": "rev",
    };
    // ACT
    item = Review.fromJson(_libraryJson);
    // ASSERT
    expect(item.firstname, "fname");
    expect(item.lastname, "lname");
    expect(item.profilePhoto, "image");
    expect(item.rating, 2.4);
    expect(item.review, "rev");
  });
}
