import 'package:LibraryManagmentSystem/classes/feedback.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given feedback full json data then fromJson() is called', () async {
    // ARRANGE
    FeedbackSerializer feedback = FeedbackSerializer();
    final Map<String, dynamic> _feedbackJson = {
      "feedback": "feed",
      "userId": "1",
      "firstname": "fname",
      "lastname": "lname",
      "profilePhoto": "photo",
    };
    // ACT
    feedback = FeedbackSerializer.fromJson(_feedbackJson);
    // ASSERT
    expect(feedback.userId, "1");
    expect(feedback.feedback, "feed");
    expect(feedback.firstname, "fname");
    expect(feedback.lastname, "lname");
    expect(feedback.profilePhoto, "photo");
  });
  test('Given feedback json data without feedback then fromJson() is called',
      () async {
    // ARRANGE
    FeedbackSerializer feedback = FeedbackSerializer();
    final Map<String, dynamic> _feedbackJson = {
      "userId": "1",
      "firstname": "fname",
      "lastname": "lname",
      "profilePhoto": "photo",
    };
    // ACT
    feedback = FeedbackSerializer.fromJson(_feedbackJson);
    // ASSERT
    expect(feedback.userId, "1");
    expect(feedback.feedback, "");
    expect(feedback.firstname, "fname");
    expect(feedback.lastname, "lname");
    expect(feedback.profilePhoto, "photo");
  });
  test('Given feedback json data without userId then fromJson() is called',
      () async {
    // ARRANGE
    FeedbackSerializer feedback = FeedbackSerializer();
    final Map<String, dynamic> _feedbackJson = {
      "feedback": "feed",
      "firstname": "fname",
      "lastname": "lname",
      "profilePhoto": "photo",
    };
    // ACT
    feedback = FeedbackSerializer.fromJson(_feedbackJson);
    // ASSERT
    expect(feedback.userId, "");
    expect(feedback.feedback, "feed");
    expect(feedback.firstname, "fname");
    expect(feedback.lastname, "lname");
    expect(feedback.profilePhoto, "photo");
  });
  test('Given feedback json data without firstname then fromJson() is called',
      () async {
    // ARRANGE
    FeedbackSerializer feedback = FeedbackSerializer();
    final Map<String, dynamic> _feedbackJson = {
      "feedback": "feed",
      "userId": "1",
      "lastname": "lname",
      "profilePhoto": "photo",
    };
    // ACT
    feedback = FeedbackSerializer.fromJson(_feedbackJson);
    // ASSERT
    expect(feedback.userId, "1");
    expect(feedback.feedback, "feed");
    expect(feedback.firstname, "");
    expect(feedback.lastname, "lname");
    expect(feedback.profilePhoto, "photo");
  });
  test('Given feedback json data without lastname then fromJson() is called',
      () async {
    // ARRANGE
    FeedbackSerializer feedback = FeedbackSerializer();
    final Map<String, dynamic> _feedbackJson = {
      "feedback": "feed",
      "userId": "1",
      "firstname": "fname",
      "profilePhoto": "photo",
    };
    // ACT
    feedback = FeedbackSerializer.fromJson(_feedbackJson);
    // ASSERT
    expect(feedback.userId, "1");
    expect(feedback.feedback, "feed");
    expect(feedback.firstname, "fname");
    expect(feedback.lastname, "");
    expect(feedback.profilePhoto, "photo");
  });
  test(
      'Given feedback json data without profilePhoto then fromJson() is called',
      () async {
    // ARRANGE
    FeedbackSerializer feedback = FeedbackSerializer();
    final Map<String, dynamic> _feedbackJson = {
      "feedback": "feed",
      "userId": "1",
      "firstname": "fname",
      "lastname": "lname",
    };
    // ACT
    feedback = FeedbackSerializer.fromJson(_feedbackJson);
    // ASSERT
    expect(feedback.userId, "1");
    expect(feedback.feedback, "feed");
    expect(feedback.firstname, "fname");
    expect(feedback.lastname, "lname");
    expect(feedback.profilePhoto, "");
  });

  test('Given feedback object full data then toJson() is called', () async {
    // ARRANGE
    FeedbackSerializer feedback = FeedbackSerializer();
    feedback = FeedbackSerializer(
      feedback: "feed",
      userId: "1",
      firstname: "fname",
      lastname: "lname",
      profilePhoto: "photo",
    );
    // ACT
    final Map<String, dynamic> _feedbackJson = feedback.toJson();
    // ASSERT
    expect(_feedbackJson['userId'], "1");
    expect(_feedbackJson['feedback'], "feed");
    expect(_feedbackJson['firstname'], "fname");
    expect(_feedbackJson['lastname'], "lname");
    expect(_feedbackJson['profilePhoto'], "photo");
  });
  test('Given feedback object without feedback data then toJson() is called',
      () async {
    // ARRANGE
    FeedbackSerializer feedback = FeedbackSerializer();
    feedback = FeedbackSerializer(
      userId: "1",
      firstname: "fname",
      lastname: "lname",
      profilePhoto: "photo",
    );
    // ACT
    final Map<String, dynamic> _feedbackJson = feedback.toJson();
    // ASSERT
    expect(_feedbackJson['userId'], "1");
    expect(_feedbackJson['feedback'], "");
    expect(_feedbackJson['firstname'], "fname");
    expect(_feedbackJson['lastname'], "lname");
    expect(_feedbackJson['profilePhoto'], "photo");
  });
  test('Given feedback object without firstname data then toJson() is called',
      () async {
    // ARRANGE
    FeedbackSerializer feedback = FeedbackSerializer();
    feedback = FeedbackSerializer(
      userId: "1",
      feedback: "feed",
      lastname: "lname",
      profilePhoto: "photo",
    );
    // ACT
    final Map<String, dynamic> _feedbackJson = feedback.toJson();
    // ASSERT
    expect(_feedbackJson['userId'], "1");
    expect(_feedbackJson['feedback'], "feed");
    expect(_feedbackJson['firstname'], "");
    expect(_feedbackJson['lastname'], "lname");
    expect(_feedbackJson['profilePhoto'], "photo");
  });
  test('Given feedback object without lastname data then toJson() is called',
      () async {
    // ARRANGE
    FeedbackSerializer feedback = FeedbackSerializer();
    feedback = FeedbackSerializer(
      userId: "1",
      feedback: "feed",
      firstname: "fname",
      profilePhoto: "photo",
    );
    // ACT
    final Map<String, dynamic> _feedbackJson = feedback.toJson();
    // ASSERT
    expect(_feedbackJson['userId'], "1");
    expect(_feedbackJson['feedback'], "feed");
    expect(_feedbackJson['firstname'], "fname");
    expect(_feedbackJson['lastname'], "");
    expect(_feedbackJson['profilePhoto'], "photo");
  });
  test(
      'Given feedback object without profilePhoto data then toJson() is called',
      () async {
    // ARRANGE
    FeedbackSerializer feedback = FeedbackSerializer();
    feedback = FeedbackSerializer(
      userId: "1",
      feedback: "feed",
      firstname: "fname",
      lastname: "lname",
    );
    // ACT
    final Map<String, dynamic> _feedbackJson = feedback.toJson();
    // ASSERT
    expect(_feedbackJson['userId'], "1");
    expect(_feedbackJson['feedback'], "feed");
    expect(_feedbackJson['firstname'], "fname");
    expect(_feedbackJson['lastname'], "lname");
    expect(_feedbackJson['profilePhoto'], "");
  });
  test('Given feedback object without feedback data then toJson() is called',
      () async {
    // ARRANGE
    FeedbackSerializer feedback = FeedbackSerializer();
    feedback = FeedbackSerializer(
      userId: "1",
      feedback: "feed",
      firstname: "fname",
      lastname: "lname",
      profilePhoto: "photo",
    );
    // ACT
    final Map<String, dynamic> _feedbackJson = feedback.toJson();
    // ASSERT
    expect(_feedbackJson['userId'], "1");
    expect(_feedbackJson['feedback'], "feed");
    expect(_feedbackJson['firstname'], "fname");
    expect(_feedbackJson['lastname'], "lname");
    expect(_feedbackJson['profilePhoto'], "photo");
  });
}
