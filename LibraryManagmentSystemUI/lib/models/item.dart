import 'package:LibraryManagmentSystem/models/available.dart';
import 'package:LibraryManagmentSystem/models/review.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable(explicitToJson: true)
class Item {
  final String id;
  final String type;
  final String genre;
  final String name;
  final String author;
  final String language;
  final String isbn;
  final String image;
  final bool inLibrary;
  final int lateFees;
  final String location;
  final int amount;
  final int averageRating;
  final bool isNew;
  Item(
      {this.id,
      this.type,
      this.genre,
      this.name,
      this.author,
      this.language,
      this.isbn,
      this.image,
      this.inLibrary,
      this.lateFees,
      this.location,
      this.amount,
      this.isNew,
      this.averageRating});

  factory Item.fromJson(Map<String, dynamic> data) => _$ItemFromJson(data);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
