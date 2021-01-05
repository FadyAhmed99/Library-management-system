// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../classes/feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackSerializer _$FeedbackFromJson(Map<String, dynamic> json) {
  return FeedbackSerializer(
    firstname: json['firstname'] as String,
    lastname: json['lastname'] as String,
    profilePhoto: json['profilePhoto'] as String,
    userId: json['userId'] as String,
    feedback: json['feedback'] as String,
  );
}

Map<String, dynamic> _$FeedbackToJson(FeedbackSerializer instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'profilePhoto': instance.profilePhoto,
      'userId': instance.userId,
      'feedback': instance.feedback,
    };
