import 'package:LibraryManagmentSystem/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable(explicitToJson: true)
class Review {
  User user;
  double rating;
  String review;

  Review({this.user, this.rating, this.review});

  factory Review.fromJson(Map<String, dynamic> data) => _$ReviewFromJson(data);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
