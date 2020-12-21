import 'package:LibraryManagmentSystem/model/library.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite.g.dart';

@JsonSerializable(explicitToJson: true)
class Favorite {
  String id;
  String type;
  String name;
  String genre;
  String language;
  String author;
  String isbn;
  String image;
  bool inLibrary;
  int lateFees;
  String location;
  int amount;
  Favorite(
      {this.id,
      this.type,
      this.name,
      this.genre,
      this.language,
      this.author,
      this.isbn,
      this.image,
      this.inLibrary,
      this.lateFees,
      this.location,
      this.amount});

  factory Favorite.fromJson(Map<String, dynamic> data) =>
      _$FavoriteFromJson(data);
  Map<String, dynamic> toJson() => _$FavoriteToJson(this);
}
