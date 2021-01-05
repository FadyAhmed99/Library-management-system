import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable(explicitToJson: true)
class Review {
  final String firstname;
  final String lastname;
  String profilePhoto;
  final double rating;
  final String review;

  Review({
    this.firstname,
    this.lastname,
    this.profilePhoto,
    this.rating,
    this.review,
  });

  factory Review.fromJson(Map<String, dynamic> data) => _$ReviewFromJson(data);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
