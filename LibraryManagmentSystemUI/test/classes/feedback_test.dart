import 'package:LibraryManagmentSystem/classes/feedback.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given feedback json data then from json is called', () async {
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
}
