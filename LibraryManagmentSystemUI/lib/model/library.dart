import 'package:json_annotation/json_annotation.dart';
import 'package:LibraryManagmentSystem/model/feedback.dart';

part 'library.g.dart';

@JsonSerializable(explicitToJson: true)
class Library {
  final String name;
  final String address;
  final String description;
  final String phoneNumber;
  final String image;
  final String librarian;
  List<Feedback> feedback;
  final String id;
  Library(
      {this.name,
      this.id,
      this.address,
      this.description,
      this.phoneNumber,
      this.image,
      this.librarian,
      this.feedback});
  factory Library.fromJson(Map<String, dynamic> data) =>
      _$LibraryFromJson(data);
  Map<String, dynamic> toJson() => _$LibraryToJson(this);
}
