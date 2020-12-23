import 'package:LibraryManagmentSystem/models/available.dart';
import 'package:LibraryManagmentSystem/models/review.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable(explicitToJson: true)
class Item {
  String name;
  String genre;
  String author;
  String language;
  String isbn;
  List<Available> available;
  List<Review> reviews;

  Item(
      {this.name,
      this.genre,
      this.author,
      this.language,
      this.isbn,
      this.available,
      this.reviews});

  factory Item.fromJson(Map<String, dynamic> data) => _$ItemFromJson(data);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
