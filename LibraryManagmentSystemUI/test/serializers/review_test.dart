import 'package:LibraryManagmentSystem/serializers/review.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given review full json data then fromJson() is called', () async {
    // ARRANGE
    Review review = Review();
    final Map<String, dynamic> _reviewJson = {
      "firstname": "fname",
      "lastname": "lname",
      "profilePhoto": "image",
      "rating": 2.4,
      "review": "rev",
    };
    // ACT
    review = Review.fromJson(_reviewJson);
    // ASSERT
    expect(review.firstname, "fname");
    expect(review.lastname, "lname");
    expect(review.profilePhoto, "image");
    expect(review.rating, 2.4);
    expect(review.review, "rev");
  });

  test('Given review json data then fromJson() is called', () async {
    // ARRANGE
    Review review = Review();
    final Map<String, dynamic> _reviewJson = {
      "firstname": "fname",
      "lastname": "lname",
      "profilePhoto": "image",
      "rating": 2.4,
      "review": "rev",
    };
    // ACT
    review = Review.fromJson(_reviewJson);
    // ASSERT
    expect(review.firstname, "fname");
    expect(review.lastname, "lname");
    expect(review.profilePhoto, "image");
    expect(review.rating, 2.4);
    expect(review.review, "rev");
  });

  test('Given review json data then fromJson() is called', () async {
    // ARRANGE
    Review review = Review();
    final Map<String, dynamic> _reviewJson = {
      "firstname": "fname",
      "lastname": "lname",
      "profilePhoto": "image",
      "rating": 2.4,
      "review": "rev",
    };
    // ACT
    review = Review.fromJson(_reviewJson);
    // ASSERT
    expect(review.firstname, "fname");
    expect(review.lastname, "lname");
    expect(review.profilePhoto, "image");
    expect(review.rating, 2.4);
    expect(review.review, "rev");
  });

  test('Given review json data then fromJson() is called', () async {
    // ARRANGE
    Review review = Review();
    final Map<String, dynamic> _reviewJson = {
      "firstname": "fname",
      "lastname": "lname",
      "profilePhoto": "image",
      "rating": 2.4,
      "review": "rev",
    };
    // ACT
    review = Review.fromJson(_reviewJson);
    // ASSERT
    expect(review.firstname, "fname");
    expect(review.lastname, "lname");
    expect(review.profilePhoto, "image");
    expect(review.rating, 2.4);
    expect(review.review, "rev");
  });

  test('Given review json data then fromJson() is called', () async {
    // ARRANGE
    Review review = Review();
    final Map<String, dynamic> _reviewJson = {
      "firstname": "fname",
      "lastname": "lname",
      "profilePhoto": "image",
      "rating": 2.4,
      "review": "rev",
    };
    // ACT
    review = Review.fromJson(_reviewJson);
    // ASSERT
    expect(review.firstname, "fname");
    expect(review.lastname, "lname");
    expect(review.profilePhoto, "image");
    expect(review.rating, 2.4);
    expect(review.review, "rev");
  });

  test('Given review object then toJson() is called', () async {
    // ARRANGE
    Review review = Review();
    review = Review(
      firstname: "fname",
      lastname: "lname",
      profilePhoto: "image",
      rating: 2.4,
      review: "rev",
    );
    // ACT
    final Map<String, dynamic> _reviewJson = review.toJson();
    // ASSERT
    expect(_reviewJson['firstname'], "fname");
    expect(_reviewJson['lastname'], "lname");
    expect(_reviewJson['profilePhoto'], "image");
    expect(_reviewJson['rating'], 2.4);
    expect(_reviewJson['review'], "rev");
  });
}
