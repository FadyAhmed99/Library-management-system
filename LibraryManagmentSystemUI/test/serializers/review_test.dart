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

  test('Given review json data without firstname then fromJson() is called',
      () async {
    // ARRANGE
    Review review = Review();
    final Map<String, dynamic> _reviewJson = {
      "lastname": "lname",
      "profilePhoto": "image",
      "rating": 2.4,
      "review": "rev",
    };
    // ACT
    review = Review.fromJson(_reviewJson);
    // ASSERT
    expect(review.firstname, "");
    expect(review.lastname, "lname");
    expect(review.profilePhoto, "image");
    expect(review.rating, 2.4);
    expect(review.review, "rev");
  });

  test('Given review json data without lastname then fromJson() is called',
      () async {
    // ARRANGE
    Review review = Review();
    final Map<String, dynamic> _reviewJson = {
      "firstname": "fname",
      "profilePhoto": "image",
      "rating": 2.4,
      "review": "rev",
    };
    // ACT
    review = Review.fromJson(_reviewJson);
    // ASSERT
    expect(review.firstname, "fname");
    expect(review.lastname, "");
    expect(review.profilePhoto, "image");
    expect(review.rating, 2.4);
    expect(review.review, "rev");
  });

  test('Given review json data without profilePhoto then fromJson() is called',
      () async {
    // ARRANGE
    Review review = Review();
    final Map<String, dynamic> _reviewJson = {
      "firstname": "fname",
      "lastname": "lname",
      "rating": 2.4,
      "review": "rev",
    };
    // ACT
    review = Review.fromJson(_reviewJson);
    // ASSERT
    expect(review.firstname, "fname");
    expect(review.lastname, "lname");
    expect(review.profilePhoto, "");
    expect(review.rating, 2.4);
    expect(review.review, "rev");
  });

  test('Given review json data without rating then fromJson() is called',
      () async {
    // ARRANGE
    Review review = Review();
    final Map<String, dynamic> _reviewJson = {
      "firstname": "fname",
      "lastname": "lname",
      "profilePhoto": "image",
      "review": "rev",
    };
    // ACT
    review = Review.fromJson(_reviewJson);
    // ASSERT
    expect(review.firstname, "fname");
    expect(review.lastname, "lname");
    expect(review.profilePhoto, "image");
    expect(review.rating, 0);
    expect(review.review, "rev");
  });

  test('Given review json data without review then fromJson() is called',
      () async {
    // ARRANGE
    Review review = Review();
    final Map<String, dynamic> _reviewJson = {
      "firstname": "fname",
      "lastname": "lname",
      "profilePhoto": "image",
    };
    // ACT
    review = Review.fromJson(_reviewJson);
    // ASSERT
    expect(review.firstname, "fname");
    expect(review.lastname, "lname");
    expect(review.profilePhoto, "image");
    expect(review.rating, 0);
    expect(review.review, "");
  });

  test('Given review object with full data then toJson() is called', () async {
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

  test(
      'Given review object without profilePhoto, review, rating data then toJson() is called',
      () async {
    // ARRANGE
    Review review = Review();
    review = Review(
      firstname: "fname",
      lastname: "lname",
    
    );
    // ACT
    final Map<String, dynamic> _reviewJson = review.toJson();
    // ASSERT
    expect(_reviewJson['firstname'], "fname");
    expect(_reviewJson['lastname'], "lname");
    expect(_reviewJson['profilePhoto'], "");
    expect(_reviewJson['rating'], 0);
    expect(_reviewJson['review'], "");
  });
}
