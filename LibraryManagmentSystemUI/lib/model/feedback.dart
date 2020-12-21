import 'package:LibraryManagmentSystem/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feedback.g.dart';

@JsonSerializable(explicitToJson: true)
class Feedback {
  User user;
  String feedback = '';

  Feedback({this.user, this.feedback});

  factory Feedback.fromJson(Map<String, dynamic> data) =>
      _$FeedbackFromJson(data);
  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}
