import 'package:json_annotation/json_annotation.dart';

part 'feedback.g.dart';

@JsonSerializable()
class Feedback {
  String firstname;
  String lastname;
  String profilePhoto;
  String userId;
  String feedback;

  Feedback(
      {this.firstname,
      this.lastname,
      this.profilePhoto,
      this.userId,
      this.feedback});

  factory Feedback.fromJson(Map<String, dynamic> data) =>
      _$FeedbackFromJson(data);
  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}
