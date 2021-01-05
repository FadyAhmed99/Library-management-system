// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return Review(
    firstname: json['firstname'] as String,
    lastname: json['lastname'] as String,
    profilePhoto: json['profilePhoto'] as String,
    rating: (json['rating'] as num)?.toDouble(),
    review: json['review'] as String,
  );
}

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'profilePhoto': instance.profilePhoto,
      'rating': instance.rating,
      'review': instance.review,
    };
