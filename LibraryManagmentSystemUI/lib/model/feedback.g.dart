// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feedback _$FeedbackFromJson(Map<String, dynamic> json) {
  return Feedback(
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    feedback: json['feedback'] as String,
  );
}

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
      'user': instance.user?.toJson(),
      'feedback': instance.feedback,
    };
