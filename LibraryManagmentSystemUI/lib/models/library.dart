
import 'package:json_annotation/json_annotation.dart';

part 'library.g.dart';

@JsonSerializable()
class Library {
  String name, address, librarian;

  Library({this.name, this.address, this.librarian});

  factory Library.fromJson(Map<String, dynamic> json) =>
      _$LibraryFromJson(json);
  Map<String, dynamic> toJson() => _$LibraryToJson(this);
}
