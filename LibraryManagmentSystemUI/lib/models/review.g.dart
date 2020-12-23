// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return Review(
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    rating: (json['rating'] as num)?.toDouble(),
    review: json['review'] as String,
  );
}

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'user': instance.user?.toJson(),
      'rating': instance.rating,
      'review': instance.review,
    };
